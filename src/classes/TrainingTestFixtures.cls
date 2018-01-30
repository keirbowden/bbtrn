@IsTest
public class TrainingTestFixtures 
{
    public static Training_Path__c GetTrainingPath(String name, Id badgeId)
    {
        Training_Path__c path=
            new Training_Path__c(Name=name,
                                 Description__c='Unit Test',
                                 Badge__c=badgeId);
        insert path;

        Training_Step__c step=
            new Training_Step__c(Name='Unit Test',
                                Training_Path__c=path.id,
                                 Description__c='Unit Test',
                                 Heading_1__c='Heading 1',
                                 Content_1__c='Content 1',
                                 Heading_2__c='Heading 1',
                                 Content_2__c='Content 1',
                                 Heading_3__c='Heading 1',
                                 Content_3__c='Content 1',
                                 Heading_4__c='Heading 1',
                                 Content_4__c='Content 1',
                                 Heading_5__c='Heading 1',
                                 Content_5__c='Content 1');

        insert step;

        return path;
    }

    public static Training_Question__c GetTrainingQuestionWithAnswers(Id stepId, String questionText, 
                                                                      Integer index, Integer answerCount)
    {
        Training_Question__c question=new Training_Question__c(Training_Step__c=stepId,
                                                               Question__c=questionText,
                                                               Index__c=index,
                                                               Correct_Answer_Index__c=1);

        insert question;

        List<Training_Answer__c> answers=new List<Training_Answer__c>();
        for (Integer idx=1; idx<=answerCount; idx++) 
        {
            Training_Answer__c answer=new Training_Answer__c(Training_Question__c=question.id,
                                                             Index__c=idx,
                                                             Answer__c='Answer ' + idx);
            answers.add(answer);
        }

        insert answers;

        return question;
    }

    public static Badge__c GetBadge(String name) 
    {
        Badge__c badge=new Badge__c(Name=name);

        insert badge;

        return badge;
    }
}
