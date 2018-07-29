public with sharing class TrainingHome 
{
    private static TrainingServiceIF trainingService {
        get{
            if (null==trainingService)
            {
                trainingService=ConfigAccessor.GetTrainingServiceFromConfig();
            }

            return trainingService;
        }
    }

    @TestVisible
    private static void SetTrainingService(TrainingServiceIF svc)
    {
        trainingService=svc;
    }

    @AuraEnabled
    public static List<TrainingPath> GetPaths(String epName, String runAsEmail)
    {
        System.debug('Getting paths for email ' + runAsEmail);
        return trainingService.GetAllPaths(epName, runAsEmail);
    }

    @AuraEnabled 
    public static TrainingPath GetPath(String epName, String pathIdStr, String runAsEmail)
    {
        return trainingService.GetPath(epName, pathIdStr, runAsEmail);
    }

    @AuraEnabled 
    public static TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        return trainingService.GetStep(epName, pathIdStr, stepIdStr, runAsEmail);
    }

    // returns true if passing the step means the user completed the path
    @AuraEnabled 
    public static TrainingResult PassStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        return trainingService.PassStep(epName, pathIdStr, stepIdStr, runAsEmail);
    }

    // returns true if passing the step means the user completed the path
    @AuraEnabled 
    public static TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr, String runAsEmail)
    {
        return trainingService.FailStepAndWait(epName, pathIdStr, stepIdStr, runAsEmail);
    }

    @AuraEnabled
    public static TrainingUserInfo GetUserInfo(String epName, String runAsEmail)
    {
        return trainingService.GetUserInfo(epName, runAsEmail);
    }

    @AuraEnabled
    public static List<TrainingEndpoint> GetAllEndpoints()
    {
        return trainingService.GetAllEndpoints();
    }

    @AuraEnabled
    public static List<TrainingPath> SearchPathsFree(String searchTerms, String runAsEmail)
    {
        return trainingService.SearchPathsFree(searchTerms, runAsEmail);
    }

    @AuraEnabled
    public static List<TrainingPath> SearchPathsTopics(String searchTerms, String runAsEmail)
    {
        return trainingService.SearchPathsTopics(searchTerms, runAsEmail);
    }

    @AuraEnabled
    // TODO in V2 - move this to the service interface
    public static Decimal GetVersion()
    {
        return TrainingServiceRemoteImpl.VERSION;
    }
}