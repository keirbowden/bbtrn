public with sharing class TrainingServiceRemoteImpl implements TrainingServiceIF 
{
    public static final String GET_ALL_PATHS_METHOD='GetPaths';
    public static final String GET_PATH_METHOD='GetPath';
    public static final String GET_STEP_METHOD='GetStep';
    public static final String PASS_STEP_METHOD='PassStep';
    public static final String FAIL_STEP_AND_WAIT_METHOD='FailStepAndWait';
    public static final String GET_USER_INFO_METHOD='GetUserInfo';

    public static final String METHOD_PARAM='method';
    public static final String EMAIL_PARAM='email';
    public static final String VERSION_PARAM='version';
    public static final String PATH_ID_PARAM='pathIdStr';
    public static final String STEP_ID_PARAM='stepIdStr';

    public static final Decimal VERSION=1.4;

    private static final String DEFAULT_ENDPOINT_NAME='Bob_Buzzard';
    private static String endpointName;

    @TestVisible
    private static TrainingEndpoint endpoint
    { 
        get {
            if (null==endpoint)
            {
                if (''==endpointName) 
                {
                    endpointName=DEFAULT_ENDPOINT_NAME;
                }
                System.debug('Getting endpoint for ' + endpointName);
                endpoint = ConfigAccessor.GetEndpoint(endpointName);
            }

            return endpoint;
        }
          
        set{
            endpoint=value;
        }
    }

    public String MakeRequest(String reqType, String method, String body)
    {
        return this.MakeRequest(reqType, method, body, null);
    }

    public String MakeRequest(String reqType, String method, String body, String email)
    {
        if (String.IsBlank(email)) {
            email=UserInfo.getUserEmail();
        }

        String result=null;

        HttpRequest req=new HttpRequest();
        req.setMethod(reqType);
        req.setHeader('Content-type', 'application/json');
        req.setEndPoint(endpoint.hostname + endpoint.path);
        String reqBody='{' + body + '"' + METHOD_PARAM + '":"' + method + '", ' + 
                         '"' + EMAIL_PARAM + '":"' + email +  '"' + ' , ' +
                         '"' + VERSION_PARAM + '":"' + VERSION +  '"' +
                            '}';
        req.setBody(reqBody);
        System.debug('Body = ' + reqBody);
        Http http=new Http();
        try
        {
            HTTPResponse resp=http.send(req);
            Integer statusCode=resp.getStatusCode();
            if (200==statusCode)
            {
                result=resp.getBody();
                System.debug('result = ' + result);
                if (endpoint.rewriteImageLinks)
                {
                    result=result.replaceAll('/servlet/rtaImage',endpoint.hostname + '/servlet/rtaImage');
                }
            }
            else if (400==statusCode)
            {
                JSONParser parser=JSON.createParser(resp.getBody());
                Map<String, String> params=new Map<String, String>();

                while (null!=parser.nextToken()) 
                {
                    if (JSONToken.FIELD_NAME==parser.getCurrentToken())
                    {
                        String name=parser.getText();
                        parser.nextToken();
                        String value=parser.getText();
                        System.debug('Name = ' + name + ', Value = ' + value);
                        params.put(name, value);
                    }
                }

                throw new AuraHandledException('Error from external training system ' + params.get('message'));
            }
            else
            {
                System.debug('Received response ' + statusCode);
                System.debug('Body = ' + resp.getBody());
                throw new AuraHandledException('An error occurred accessing the external training service');
            }
        }
        catch (System.CalloutException e)
        {
            System.debug('Callout failed - ' + e.getMessage());
        }

        return result;
    }

    public List<TrainingEndpoint> GetAllEndpoints()
    {
        return ConfigAccessor.GetAllEndpoints();
    }
    
    // Gets all the paths even if the user has completed them
    public List<TrainingPath> GetAllPaths(String epName, String runAsEmail)
    {
        endpointName=epName;
        List<TrainingPath> paths;
        String json=MakeRequest('POST', GET_ALL_PATHS_METHOD, '', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            paths=(List<TrainingPath>) System.JSON.deserialize(json, List<TrainingPath>.class);
        }

        return paths;
    }

    // Gets the details of a single path, including a high level
    // view of the steps
    public TrainingPath GetPath(String epName, String pathIdStr, String runAsEmail)
    {
        endpointName=epName;
        TrainingPath path=null;
        String json=MakeRequest('POST', GET_PATH_METHOD, '"' + PATH_ID_PARAM + '":"' + pathIdStr + '",', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            path=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return path;
    }

    // Gets the details of a step, including the questions
    // and answers
    public TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        endpointName=epName;
        TrainingPath path=null;
        String json=MakeRequest('POST', 'GetStep', '"' + PATH_ID_PARAM + '":"' + pathIdStr + '","' + STEP_ID_PARAM + '":"' + stepIdStr + '",', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            path=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return path;
    }

    // Marks a user as having passed a step. If this means that
    // the user has passed the path, returns true
    public TrainingResult PassStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        endpointName=epName;
        TrainingResult result;
        String json=MakeRequest('POST', 'PassStep', '"' + PATH_ID_PARAM + '":"' + pathIdStr + '","' + STEP_ID_PARAM + '":"' + stepIdStr + '",', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            result=(TrainingResult) System.JSON.deserialize(json, TrainingResult.class);
        }

        return result;
    }
    
    public TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        endpointName=epName;
        TrainingPath result;
        String json=MakeRequest('POST', 'FailStepAndWait', '"' + PATH_ID_PARAM + '":"' + pathIdStr + '","' + STEP_ID_PARAM + '":"' + stepIdStr + '",', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            result=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return result;
    }
    
    // Gets the user infomation, such as badges, points etc
    public TrainingUserInfo GetUserInfo(String epName, String runAsEmail)
    {
        endpointName=epName;
        TrainingUserInfo info;
        String json=MakeRequest('POST', GET_USER_INFO_METHOD, '', runAsEmail);
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            info=(TrainingUserInfo) System.JSON.deserialize(json, TrainingUserInfo.class);
        }

        // add the local user information, as the remote site only has the email address
        info.firstname=UserInfo.getFirstName();
        info.lastname=UserInfo.getLastName();
        info.initials=info.firstname.substring(0, 1) + info.lastname.substring(0, 1);

    	// get the custom permission and associated permission set id
		CustomPermission custPerm=[select Id,
										  (select Id, ParentId, Parent.Name, Parent.Profile.Name from SetupEntityAccessItems)
										  from CustomPermission
                                          where DeveloperName='Training_Run_As'];
	
        List<Id> permSetIds=new List<Id>();
		for (SetupEntityAccess sea : custPerm.SetupEntityAccessItems)
		{
			permSetIds.add(sea.parentId);
		}

		List<PermissionSetAssignment> psas=[select Id, AssigneeId
											from PermissionSetAssignment
											where PermissionSetId IN :permSetIds
											and AssigneeId=:UserInfo.getUserId()];  

        info.canRunAs=!psas.IsEmpty();

        return info;
    }
}