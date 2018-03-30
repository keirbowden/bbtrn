@IsTest
global class TrainingServiceRemoteMock implements HttpCalloutMock 
{
    global HTTPResponse respond(HTTPRequest req) 
    {
        String body=req.getBody();
        System.debug('Body = ' + body);
        JSONParser parser=JSON.createParser(body);
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

        String method=params.get(TrainingServiceRemoteImpl.METHOD_PARAM);

        String result;

        if (TrainingServiceRemoteImpl.GET_ALL_PATHS_METHOD==method) 
        {
            List<TrainingPath> paths=new List<TrainingPath>();
            paths.add(TrainingFixtures.GetPath(3));
            paths.add(TrainingFixtures.GetPath(2));
            result=JSON.serialize(paths);
        }
        else if (TrainingServiceRemoteImpl.GET_PATH_METHOD==method) 
        {
            String pathIdStr=params.get(TrainingServiceRemoteImpl.PATH_ID_PARAM);
            System.assertNotEquals(null, pathIdStr, TrainingServiceRemoteImpl.GET_PATH_METHOD + ' must supply a path id');
            TrainingPath path=TrainingFixtures.GetPath(5);
            result=JSON.serialize(path);
        }
        else if (TrainingServiceRemoteImpl.GET_STEP_METHOD==method) 
        {
            TrainingPath path=TrainingFixtures.GetPath(1);
            result=JSON.serialize(path);
        }
        else if (TrainingServiceRemoteImpl.PASS_STEP_METHOD==method)
        {
            TrainingResult trResult=new TrainingResult();
            trResult.result=true;
            result=JSON.serialize(trResult);
        }
        else if (TrainingServiceRemoteImpl.FAIL_STEP_AND_WAIT_METHOD==method)
        {
            TrainingPath path=TrainingFixtures.GetPath(1);
            result=JSON.serialize(path);
        }
        else if (TrainingServiceRemoteImpl.GET_USER_INFO_METHOD==method)
        {
            TrainingUserInfo info=TrainingFixtures.GetUserInfo(3);
            result=JSON.serialize(info);  
        }

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(result);
        res.setStatusCode(200);

        return res;
    }
}