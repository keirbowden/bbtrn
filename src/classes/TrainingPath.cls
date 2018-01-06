public class TrainingPath
{
    @AuraEnabled 
    public String pathId {get; set;}

    @AuraEnabled 
    public String name {get; set;}

    @AuraEnabled 
    public String description {get; set;}

    @AuraEnabled 
    public Integer percentComplete {get; set;}

    @AuraEnabled
    public Boolean complete {get; set;}
    
    @AuraEnabled
    public List<TrainingStep> steps {get; set;}

    public TrainingPath()
    {
        steps=new List<TrainingStep>();
    }

    public class TrainingStep
    {
        @AuraEnabled 
        public String id {get; set;}

        @AuraEnabled 
        public String name {get; set;}

        @AuraEnabled 
        public String description {get; set;}

        @AuraEnabled
        public Boolean complete {get; set;}
        
        @AuraEnabled
        public Boolean pass;
        
        @AuraEnabled
        public List<TrainingStepSection> sections {get; set;}

        @AuraEnabled
        public List<TrainingStepQuestion> questions {get;set;}

        public TrainingStep()
        {
            questions=new List<TrainingStepQuestion>();
            sections=new List<TrainingStepSection>();
        }
    }

    public class TrainingStepSection
    {
        @AuraEnabled
        public String heading;
        
        @AuraEnabled
        public String content;
    }

    public class TrainingStepQuestion
    {
        @AuraEnabled
        public Integer idx {get; set;}

        @AuraEnabled
        public String question {get; set;}
        
        @AuraEnabled
        public Integer correct;

        @AuraEnabled
        public String selectedAnswerId;

        @AuraEnabled
        public List<TrainingStepAnswer> answers {get; set;}

        public TrainingStepQuestion()
        {
            answers=new List<TrainingStepAnswer>();
        }
    }

    public class TrainingStepAnswer
    {
        @AuraEnabled
        public Integer idx {get; set;}

        @AuraEnabled
        public String state {get; set;}

        @AuraEnabled
        public String answer {get; set;}
    }
}