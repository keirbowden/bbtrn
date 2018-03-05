public with sharing class TrainingEndpoint {
    @AuraEnabled
    public String name {get; set;}

    @AuraEnabled
    public String hostname {get; set;}

    @AuraEnabled
    public String path {get; set;}

    @AuraEnabled
    public Boolean rewriteImageLinks {get; set;}

    public TrainingEndpoint() {

    }
}
