public with sharing class ConfigAccessor {
    private static final String DEVELOPER_NAME='DeveloperName';
    private static final String SERVICE_MDT='Training_Config__mdt';
    private static final String SERVICE_MDT_SERVICE_FIELD='Service_Implementation__c';
    private static final String SERVICE_MDT_INSTANCE_NAME='Default';

    private static final String ENDPOINT_MDT='Training_Endpoint__mdt';
    private static final String ENDPOINT_MDT_HOSTNAME='Hostname__c';
    private static final String ENDPOINT_MDT_PATH='Path__c';
    private static final String ENDPOINT_MDT_REWRITE_IMAGE_LINKS='Rewrite_Image_Links__c';

    public static TrainingEndpoint GetEndpoint(String endpointName)
    {
        String query='select ' + DEVELOPER_NAME + ', ' +
                                 ENDPOINT_MDT_HOSTNAME + ', ' +
                                 ENDPOINT_MDT_PATH + ', ' +
                                 ENDPOINT_MDT_REWRITE_IMAGE_LINKS + 
                     ' from ' + ENDPOINT_MDT +
                     ' where ' + DEVELOPER_NAME + '= \'' + endpointName + '\'';

        SObject endpoint=Database.query(query);

        TrainingEndpoint result=new TrainingEndpoint();
        result.name=(String) endpoint.get(DEVELOPER_NAME);
        result.hostname = (String) endpoint.get(ENDPOINT_MDT_HOSTNAME);
        result.path = (String) endpoint.get(ENDPOINT_MDT_PATH);
        result.rewriteImageLinks = (Boolean) endpoint.get(ENDPOINT_MDT_REWRITE_IMAGE_LINKS);

        return result;
    }

    public static List<TrainingEndpoint> GetAllEndpoints()
    {
        String query='select ' + DEVELOPER_NAME + ', ' +
                                 ENDPOINT_MDT_HOSTNAME + ', ' +
                                 ENDPOINT_MDT_PATH + ', ' +
                                 ENDPOINT_MDT_REWRITE_IMAGE_LINKS + 
                     ' from ' + ENDPOINT_MDT;

        List<SObject> endpoints=Database.query(query);
  
        List<TrainingEndpoint> result=new List<TrainingEndpoint>();
        for (SObject endpoint : endpoints)
        {
            TrainingEndpoint ep=new TrainingEndpoint();
            ep.name=(String) endpoint.get(DEVELOPER_NAME);
            ep.hostname = (String) endpoint.get(ENDPOINT_MDT_HOSTNAME);
            ep.path = (String) endpoint.get(ENDPOINT_MDT_PATH);
            ep.rewriteImageLinks = (Boolean) endpoint.get(ENDPOINT_MDT_REWRITE_IMAGE_LINKS);
            result.add(ep);
        }

        return result;
    }

    public static TrainingServiceIF GetTrainingServiceFromConfig()
    {
        String query='select ' + SERVICE_MDT_SERVICE_FIELD + 
                     ' from ' + SERVICE_MDT +
                     ' where ' + DEVELOPER_NAME + '=\'' + SERVICE_MDT_INSTANCE_NAME + '\'';

        SObject trainCfg=Database.query(query);
        String impl=(String) trainCfg.get(SERVICE_MDT_SERVICE_FIELD);
        System.debug('Implementation = ' + impl);
        Type tp=Type.forName(impl);
        System.debug('Type = ' + tp);
        TrainingServiceIF trainingService = (TrainingServiceIF) tp.newInstance(); 

        return trainingService;
    }
}
