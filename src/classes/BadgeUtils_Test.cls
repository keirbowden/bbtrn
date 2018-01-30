@IsTest
private class BadgeUtils_Test 
{
    @IsTest
    static void AssignBadgeIfPathComplete_Test()
    {
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c path=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);

        Candidate_Path__c cp=DataAccessor.GetOrCreateCandidatePath(path.id, UserInfo.GetUserId());
        List<Candidate_Step__c> cSteps=[select id, Complete__c 
                                        from Candidate_Step__c
                                        where Candidate_Path__c=:cp.id];

        for (Candidate_Step__c cStep : cSteps)
        {
            cStep.Complete__c=true;
        }
        update cSteps;

        BadgeUtils.AssignBadgeIfPathComplete(new List<Candidate_Path__c>{cp});

        List<Candidate_Badge__c> cBadges=[select id from Candidate_Badge__c];
        System.assertEquals(1, cBadges.size());
    }
}
