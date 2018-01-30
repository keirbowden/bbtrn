public with sharing class TrainingHome 
{
    private static TrainingServiceIF trainingService {
        get{
            if (null==trainingService)
            {
                Training_Config__mdt config = [select Service_Implementation__c 
                                               from Training_Config__mdt
                                               where DeveloperName='Default'];
                System.debug('Implementation = ' + config.Service_Implementation__c);
                Type tp=Type.forName(config.Service_Implementation__c);
                System.debug('Type = ' + tp);
                trainingService = (TrainingServiceIF) tp.newInstance(); 
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
    public static List<String> GetAllEndpoints()
    {
        return trainingService.GetAllEndpoints();
    }
}