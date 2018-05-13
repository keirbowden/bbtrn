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
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        List<TrainingPath> paths=service.GetAllPaths('Test', null);

        Test.stopTest();
        System.assertEquals(2, paths.size());

    }

    @IsTest
    static void TestGetPath()
    {
        SetupService();
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.GetPath('Test', 'Mock', null);
        Test.stopTest();
        System.assertEquals(5, path.steps.size());
    }

    @IsTest
    static void TestGetStep()
    {
        SetupService();
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.GetStep('Test', 'Mock', 'Step 1', null);
        Test.stopTest();
        System.assertEquals(1, path.steps.size());
    }

    @IsTest
    static void PassStep()
    {
        SetupService();
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingResult result=service.PassStep('Test', 'Mock', 'Step1', null);
        Test.stopTest();
        System.assertEquals(true, result.result);
    }

    @IsTest
    static void FailStepAndWait()
    {
        SetupService();
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingPath path=service.FailStepAndWait('Test', 'Mock', 'Step1', null);
        Test.stopTest();
        System.assertEquals(1, path.steps.size());
    }


    @IsTest
    static void GetUserInfo()
    {
        SetupService();
        Test.startTest();
        TrainingServiceRemoteImpl service=new TrainingServiceRemoteImpl();
        
        TrainingUserInfo info=service.GetUserInfo('Test', null);
        Test.stopTest();
        System.assertEquals(3, info.badges.size());
    }
}
