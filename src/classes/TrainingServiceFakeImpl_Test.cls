@IsTest
private class TrainingServiceFakeImpl_Test 
{
    @IsTest
    static void FakeService_Test()
    {
        // fake service so no need to verify anything
        TrainingServiceFakeImpl service=new TrainingServiceFakeImpl();

        service.GetAllPaths('');
        service.GetPath('', 'test');
        service.GetStep('', 'test', '1');
        service.PassStep('', 'test', 'test');
        service.PassStep('', 'test', 'test');
        service.GetUserInfo('');
        service.GetAllEndpoints();
    }
}
