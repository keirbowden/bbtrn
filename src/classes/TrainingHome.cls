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
    public static List<TrainingPath> GetPaths(String epName)
    {
        return trainingService.GetAllPaths(epName);
    }

    @AuraEnabled 
    public static TrainingPath GetPath(String epName, String pathIdStr)
    {
        return trainingService.GetPath(epName, pathIdStr);
    }

    @AuraEnabled 
    public static TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr)
    {
        return trainingService.GetStep(epName, pathIdStr, stepIdStr);
    }

    // returns true if passing the step means the user completed the path
    @AuraEnabled 
    public static Boolean PassStep(String epName, String pathIdStr, String stepIdStr)
    {
        return trainingService.PassStep(epName, pathIdStr, stepIdStr);
    }

    // returns true if passing the step means the user completed the path
    @AuraEnabled 
    public static TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr)
    {
        return trainingService.FailStepAndWait(epName, pathIdStr, stepIdStr);
    }

    @AuraEnabled
    public static TrainingUserInfo GetUserInfo(String epName)
    {
        return trainingService.GetUserInfo(epName);
    }

    @AuraEnabled
    public static List<TrainingEndpoint> GetAllEndpoints()
    {
        return trainingService.GetAllEndpoints();
    }
}