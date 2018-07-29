public with sharing class ConfigAccessor {
    private static final String DEVELOPER_NAME='DeveloperName';
    @TestVisible private static final String SERVICE_MDT='Training_Config__mdt';
    @TestVisible private static final String SERVICE_MDT_SERVICE_FIELD='Service_Implementation__c';
    private static final String SERVICE_MDT_INSTANCE_NAME='Default';

    @TestVisible private static final String ENDPOINT_MDT='Training_Endpoint__mdt';
    private static final String ENDPOINT_MDT_HOSTNAME='Hostname__c';
    private static final String ENDPOINT_MDT_PATH='Path__c';
    private static final String ENDPOINT_MDT_REWRITE_IMAGE_LINKS='Rewrite_Image_Links__c';

    @TestVisible private static sObject TestEndpoint;

    @TestVisible private static List<sObject> TestEndpoints;

    @TestVisible private static sObject TestTrainCfg;

    public static TrainingEndpoint GetEndpoint(String endpointName)
    {
        String query='select ' + DEVELOPER_NAME + ', ' +
                                 ENDPOINT_MDT_HOSTNAME + ', ' +
                                 ENDPOINT_MDT_PATH + ', ' +
                                 ENDPOINT_MDT_REWRITE_IMAGE_LINKS + 
                     ' from ' + ENDPOINT_MDT +
                     ' where ' + DEVELOPER_NAME + '= \'' + endpointName + '\'';

        SObject endpoint;
        List<SObject> endpoints=Database.query(query);
        if (endpoints.size()>0)
        {
            endpoint=endpoints[0];
        }
        if (null!=TestEndpoint) 
        {
            endpoint=TestEndpoint;
        }

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
        List<String> userEndpoints=new List<String>();

        Set<String> userFields = Schema.SObjectType.User.fields.getMap().keySet();
        for (String uf : userFields)
        {
            System.debug('Field = ' + uf);
        }
        if (userFields.contains('endpoints__c')) 
        {
            System.debug('Found the field!');
            List<User> users=Database.query('select Endpoints__c from User where Id=\'' + UserInfo.getUserId() + '\'');
            System.debug('Users = ' + users);
            userEndpoints=((String) users[0].get('Endpoints__c')).split(':');
            System.debug('User endpoints = ' + userEndpoints);
        }

        List<TrainingEndpoint> result=new List<TrainingEndpoint>();
        for (SObject endpoint : endpoints)
        {
            Boolean useEndpoint=true;
            String name=(String) endpoint.get(DEVELOPER_NAME);
            if (!userEndpoints.isEmpty())
            {
                useEndpoint=userEndpoints.contains(name);
            }

            if (useEndpoint)
            {
                TrainingEndpoint ep=new TrainingEndpoint();
                ep.name=(String) endpoint.get(DEVELOPER_NAME);
                ep.hostname = (String) endpoint.get(ENDPOINT_MDT_HOSTNAME);
                ep.path = (String) endpoint.get(ENDPOINT_MDT_PATH);
                ep.rewriteImageLinks = (Boolean) endpoint.get(ENDPOINT_MDT_REWRITE_IMAGE_LINKS);
                result.add(ep);
            }
        }

        return result;
    }

    public static TrainingServiceIF GetTrainingServiceFromConfig()
    {
        String query='select ' + SERVICE_MDT_SERVICE_FIELD + 
                     ' from ' + SERVICE_MDT +
                     ' where ' + DEVELOPER_NAME + '=\'' + SERVICE_MDT_INSTANCE_NAME + '\'';

        SObject trainCfg;
        List<SObject> trainCfgs=Database.query(query);
        if (trainCfgs.size()>0)
        {
            trainCfg=trainCfgs[0];
        }
        if (null!=TestTrainCfg)
        {
            trainCfg=TestTrainCfg;
        }
        String impl=(String) trainCfg.get(SERVICE_MDT_SERVICE_FIELD);
        TrainingServiceIF trainingService = null; 
        System.debug('Implementation = ' + impl);
        if (null!=impl)
        {
            Type tp=Type.forName(impl);
            System.debug('Type = ' + tp);
            trainingService = (TrainingServiceIF) tp.newInstance(); 
        }

        return trainingService;
    }
}
