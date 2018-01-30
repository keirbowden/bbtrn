public with sharing class TrainingServiceRemoteImpl implements TrainingServiceIF 
{
    private static final String DEFAULT_ENDPOINT_NAME='Bob_Buzzard';
    private static String endpointName;

    private static Training_Endpoint__mdt endpoint
    { 
        get {
            if (null==endpoint)
            {
                if (''==endpointName) 
                {
                    endpointName=DEFAULT_ENDPOINT_NAME;
                }
                System.debug('Getting endpoint for ' + endpointName);
                endpoint = [select MasterLabel,
                                   DeveloperName,
                                   Hostname__c,
                                   Path__c,
                                   Rewrite_Image_Links__c
                            from Training_Endpoint__mdt
                            where DeveloperName=:endpointName];
            }

            return endpoint;
        }
          
        set{}
    }

    public String MakeRequest(String reqType, String method, String body)
    {
        String result=null;

        HttpRequest req=new HttpRequest();
        req.setMethod(reqType);
        req.setHeader('Content-type', 'application/json');
        req.setEndPoint(endpoint.Hostname__c + endpoint.Path__c);
        String reqBody='{' + body + '"method":"' + method + '", "email":"' + UserInfo.getUserEmail() + '"}';
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
                if (endpoint.Rewrite_Image_Links__c)
                {
                    result=result.replaceAll('/servlet/rtaImage',endpoint.Hostname__c + '/servlet/rtaImage');
                }
            }
            else
            {
                System.debug('Received response ' + statusCode);
            }
        }
        catch (System.CalloutException e)
        {
            System.debug('Callout failed - ' + e.getMessage());
        }

        return result;
    }

    public List<String> GetAllEndpoints()
    {
        List<Training_Endpoint__mdt> endpoints=
                    [select DeveloperName
                    from Training_Endpoint__mdt];
  
        List<String> result=new List<String>();
        for (Training_Endpoint__mdt endpoint : endpoints)
        {
            result.add(endpoint.DeveloperName);
        }

        return result;
    }
    
    // Gets all the paths even if the user has completed them
    public List<TrainingPath> GetAllPaths(String epName)
    {
        endpointName=epName;
        List<TrainingPath> paths;
        String json=MakeRequest('POST', 'GetPaths', '');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            paths=(List<TrainingPath>) System.JSON.deserialize(json, List<TrainingPath>.class);
        }

        return paths;
    }

    // Gets the details of a single path, including a high level
    // view of the steps
    public TrainingPath GetPath(String epName, String pathIdStr)
    {
        endpointName=epName;
        TrainingPath path=null;
        String json=MakeRequest('POST', 'GetPath', '"pathIdStr":"' + pathIdStr + '",');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            path=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return path;
    }

    // Gets the details of a step, including the questions
    // and answers
    public TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr)
    {
        endpointName=epName;
        TrainingPath path=null;
        String json=MakeRequest('POST', 'GetStep', '"pathIdStr":"' + pathIdStr + '","stepIdStr":"' + stepIdStr + '",');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            path=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return path;
    }

    // Marks a user as having passed a step. If this means that
    // the user has passed the path, returns true
    public Boolean PassStep(String epName, String pathIdStr, String stepIdStr)
    {
        endpointName=epName;
        Boolean result=false;
        String json=MakeRequest('POST', 'PassStep', '"pathIdStr":"' + pathIdStr + '","stepIdStr":"' + stepIdStr + '",');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            result=(Boolean) System.JSON.deserialize(json, Boolean.class);
        }

        return result;
    }
    
    public TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr)
    {
        endpointName=epName;
        TrainingPath result;
        String json=MakeRequest('POST', 'FailStepAndWait', '"pathIdStr":"' + pathIdStr + '","stepIdStr":"' + stepIdStr + '",');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            result=(TrainingPath) System.JSON.deserialize(json, TrainingPath.class);
        }

        return result;
    }
    
    // Gets the user infomation, such as badges, points etc
    public TrainingUserInfo GetUserInfo(String epName)
    {
        endpointName=epName;
        TrainingUserInfo info;
        String json=MakeRequest('POST', 'GetUserInfo', '');
        System.debug('JSON = ' + json);
        if (null!=json)
        {
            info=(TrainingUserInfo) System.JSON.deserialize(json, TrainingUserInfo.class);
        }

        // add the local user information, as the remote site only has the email address
        info.firstname=UserInfo.getFirstName();
        info.lastname=UserInfo.getLastName();
        info.initials=info.firstname.substring(0, 1) + info.lastname.substring(0, 1);

        return info;
    }
}