@IsTest
private class TrainingHome_Test 
{
    static void SetService()
    {           
        TrainingServiceIF service=new TrainingServiceLocalImpl();
        TrainingHome.SetTrainingService(service);
    }

    @IsTest
    static void GetPaths_Test()
    {
        SetService();
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c path=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);
        List<TrainingPath> paths=TrainingHome.GetPaths(null);

        System.assertEquals(1, paths.size());
    }

    @IsTest
    static void GetPath_Test()
    {
        SetService();
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c tPath=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);
        TrainingPath path=TrainingHome.GetPath(null, tPath.id);

        System.assertEquals('Unit Test', path.name);
    }

    @IsTest
    static void GetStep_Test()
    {
        SetService();
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c tPath=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);
        Candidate_Path__c cp=DataAccessor.GetOrCreateCandidatePath(tPath.id, UserInfo.GetUserId());
        Training_Step__c tStep=[select id from Training_Step__c
                                where Training_Path__c=:tPath.id][0];
        TrainingPath path=TrainingHome.GetStep('', tPath.Id, tStep.Id);
        System.assertEquals(tStep.Id, path.steps[0].id);
    }

    @IsTest
    static void PassStep_Test()
    {
        SetService();
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c tPath=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);
        Candidate_Path__c cp=DataAccessor.GetOrCreateCandidatePath(tPath.id, UserInfo.GetUserId());
        Training_Step__c tStep=[select id from Training_Step__c
                                where Training_Path__c=:tPath.id][0];
        Boolean pathComplete=TrainingHome.PassStep('', tPath.Id, tStep.Id);
        System.assertEquals(true, pathComplete);
    }

    @IsTest 
    static void GetUserInfo()
    {
        SetService();
        TrainingHome.GetUserInfo('');
    }

    @IsTest 
    static void GetAllEndpoints_Test()
    {
        SetService();
        List<TrainingEndpoint> eps=TrainingHome.GetAllEndpoints();
        System.assertEquals(1, eps.size());
    }
}
