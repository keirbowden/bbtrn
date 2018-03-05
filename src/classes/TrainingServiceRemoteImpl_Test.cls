@IsTest
private class TrainingServiceRemoteImpl_Test 
{
    static void SetupService()
    {
        TrainingEndpoint ep=new TrainingEndpoint();
        ep.name='Test';
        ep.hostname='http://test.test.test';
        ep.path='TestAPI';
        ep.rewriteImageLinks=true;
        TrainingServiceRemoteImpl.endpoint  = ep;
        System.debug('Endpoint = ' + TrainingServiceRemoteImpl.endpoint);
        Test.setMock(HttpCalloutMock.class, new TrainingServiceRemoteMock());
    }

    @IsTest
    static void TestGetAllPaths()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        List<TrainingPath> paths=service.GetAllPaths('Test');

        System.assertEquals(2, paths.size());

    }

    @IsTest
    static void TestGetPath()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.GetPath('Test', 'Mock');
        System.assertEquals(5, path.steps.size());
    }

    @IsTest
    static void TestGetStep()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.GetStep('Test', 'Mock', 'Step 1');
        System.assertEquals(1, path.steps.size());
    }

    @IsTest
    static void PassStep()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        Boolean passed=service.PassStep('Test', 'Mock', 'Step1');
        System.assertEquals(true, passed);
    }

    @IsTest
    static void FailStepAndWait()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.FailStepAndWait('Test', 'Mock', 'Step1');
        System.assertEquals(1, path.steps.size());
    }


    @IsTest
    static void GetUserInfo()
    {
        SetupService();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingUserInfo info=service.GetUserInfo('Test');
        System.assertEquals(3, info.badges.size());
    }
}
