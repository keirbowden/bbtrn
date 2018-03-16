@IsTest
private class ConfigAccessorTest 
{
    @IsTest
    private static void GetEndpointTest()
    {
        sObject testEndpoint = (sObject) Type.forName(ConfigAccessor.ENDPOINT_MDT).newInstance();
        ConfigAccessor.TestEndpoint=testEndPoint;
        ConfigAccessor.GetEndpoint('Unit Test');
    }

    @IsTest
    private static void GetAllEndpointsTest()
    {
        sObject testEndpoint = (sObject) Type.forName(ConfigAccessor.ENDPOINT_MDT).newInstance();
        ConfigAccessor.TestEndpoints=new List<sObject> {testEndPoint};
        ConfigAccessor.GetAllEndpoints();
    }

    @IsTest
    private static void GetTrainingServiceFromConfigTest()
    {
        sObject testCfg = (sObject) Type.forName(ConfigAccessor.SERVICE_MDT).newInstance();
        ConfigAccessor.TestTrainCfg=testCfg;
        ConfigAccessor.GetTrainingServiceFromConfig();
    }
}
