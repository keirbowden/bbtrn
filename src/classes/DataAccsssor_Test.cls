@IsTest
private class DataAccsssor_Test 
{
    @IsTest
    static void GetUserAccessibleTrainingPaths_IncludeTest()
    {
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c tPath=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);

        String email=UserInfo.getUserEmail();
        String domain=email.split('@')[1];
        Candidate_Restrictions__c cr=
                new Candidate_Restrictions__c(Domain__c=domain,
                                              Include_Emails__c=email);
        insert cr;

        Training_Path_Candidate_Restriction__c tpcr=
                new Training_Path_Candidate_Restriction__c(Candidate_Restriction__c=cr.id,
                                                           Training_Path__c=tPath.id);
        insert tpcr;

        List<Training_Path__c> paths=
                DataAccessor.GetUserAccessibleTrainingPaths(
                            new List<Training_Path__c>{tPath},
                            UserInfo.GetUserId());

        System.assertEquals(1, paths.size());
    }

    @IsTest
    static void GetUserAccessibleTrainingPaths_ExcludeTest()
    {
        Badge__c badge=TrainingTestFixtures.GetBadge('Test');
        Training_Path__c tPath=TrainingTestFixtures.GetTrainingPath('Unit Test', badge.id);

        String email=UserInfo.getUserEmail();
        String domain=email.split('@')[1];
        Candidate_Restrictions__c cr=
                new Candidate_Restrictions__c(Domain__c=domain,
                                              Exclude_Emails__c=email);
        insert cr;

        Training_Path_Candidate_Restriction__c tpcr=
                new Training_Path_Candidate_Restriction__c(Candidate_Restriction__c=cr.id,
                                                           Training_Path__c=tPath.id);
        insert tpcr;

        List<Training_Path__c> paths=
                DataAccessor.GetUserAccessibleTrainingPaths(
                            new List<Training_Path__c>{tPath},
                            UserInfo.GetUserId());

        System.assertEquals(0, paths.size());
    }
}
