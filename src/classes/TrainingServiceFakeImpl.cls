public with sharing class TrainingServiceFakeImpl implements TrainingServiceIF
{
    public List<TrainingPath> GetAllPaths(String epName)
    {
        List<TrainingPath> result=new List<TrainingPath>();
        for (Integer idx=0; idx<20; idx++)
        {
            TrainingPath path=new TrainingPath();
            path.pathId=''+idx;
            path.name='Test Path ' + idx;
            path.summary='Test Path for POC';
            path.namespace='TS';
            path.percentComplete=(Math.Random()*100).intValue();
            path.topics='Test,Fake,Made Up';
            result.add(path);
        }
        
        return result;
    }

    public TrainingPath GetPath(String epName, String pathIdStr)
    {
        TrainingPath path=new TrainingPath();
        path.Name='Test Path ' + pathIdStr;
        path.summary='Test path ' + pathIdStr + ' for POC';
        path.namespace='TS';
        for (Integer idx=0; idx<5; idx++)
        {
            TrainingPath.TrainingStep step=new TrainingPath.TrainingStep();
            step.id=''+idx;
            step.name=path.name + ' step ' + (idx+1);
            step.description='In this step you\'ll learn loads of great stuff';
            if (idx<3) {
                step.complete=true;
            }
            path.steps.add(step);
        }

        return path;
    }

    public TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr)
    {
        TrainingPath path=new TrainingPath();
        path.name='Test Path ' + pathIdStr;
        TrainingPath.TrainingStep step=new TrainingPath.TrainingStep();
        step.id=stepIdStr;
        if (Integer.valueOf(stepIdStr)<3) {
            step.complete=true;
        }
        else {
            step.complete=false;
        }
        step.name=path.name + ' step ' + stepIdStr;
        step.description='Some details of the step';
        TrainingPath.TrainingStepSection section=new TrainingPath.TrainingStepSection();
        section.heading='Big Heading';
        section.content='Hello from Keir <b>with formatting</b>.';
        step.sections.add(section);
        section=new TrainingPath.TrainingStepSection();
        section.heading='Second Heading';
        section.content='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar quis sem ut porttitor. Ut euismod interdum ornare. Mauris vitae ipsum rutrum, consequat nibh id, aliquet eros. In tristique neque tortor, vitae euismod diam convallis non. Suspendisse hendrerit egestas pretium. Aliquam id sem nec dui consectetur mattis. Donec sit amet odio ac nisi varius consequat. Vestibulum vitae laoreet lectus, sit amet dapibus mauris. Pellentesque ac nisi in nulla pretium fringilla. Praesent at ullamcorper dolor, id porta nibh. Proin sit amet est in quam efficitur pretium vel id arcu. Proin non nulla cursus, fringilla turpis at, luctus nunc. Integer convallis lacus nibh, quis tincidunt risus vehicula vitae. Etiam iaculis hendrerit facilisis. Quisque fermentum, felis non elementum porta, ante ex ullamcorper turpis, id sagittis magna leo egestas mi.';
        step.sections.add(section);
        TrainingPath.TrainingStepQuestion question=new TrainingPath.TrainingStepQuestion();
        question.idx=1;
        question.question='What is the difference between a duck?';
        TrainingPath.TrainingStepAnswer a1=new TrainingPath.TrainingStepAnswer();
        a1.answer='It quacks';
        a1.idx=10;
        question.answers.add(a1);
        TrainingPath.TrainingStepAnswer a2=new TrainingPath.TrainingStepAnswer();
        a2.answer='One of it\'s legs is both the same';
        a2.idx=20;
        question.answers.add(a2);
        question.correct=20;
        step.questions.add(question);

        question=new TrainingPath.TrainingStepQuestion();
        question.idx=2;
        question.question='Why is grass?';
        a1=new TrainingPath.TrainingStepAnswer();
        a1.answer='Because chlorophyll';
        a1.idx=10;
        question.answers.add(a1);
        a2=new TrainingPath.TrainingStepAnswer();
        a2.answer='Because seeds';
        a2.idx=20;
        question.answers.add(a2);
        question.correct=20;
        step.questions.add(question);
        path.steps.add(step);

        return path;
    }

    public TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr)
    {
        return GetPath(epName, pathIdStr);
    }
    
    public Boolean PassStep(String epName, String pathIdStr, String stepIdStr)
    {
        return true;
    }

    public TrainingUserInfo GetUserInfo(String epName)
    {
        TrainingUserInfo result=new TrainingUserInfo();
        result.email=UserInfo.getUserEmail();
        result.firstname=UserInfo.getFirstName();
        result.lastname=UserInfo.getLastName();
        result.initials=result.firstname.substring(0, 1) + result.lastname.substring(0, 1);
        result.points=25000;
        result.badgeCount=12;

        for (Integer idx=0; idx<12; idx++) 
        {
            TrainingUserInfo.UserBadge ub=new TrainingUserInfo.UserBadge();
            ub.name='Test ' + idx;
            ub.description='Test badge for Fake Service';
            ub.whenEarned=System.now().addDays(-idx);
            result.badges.add(ub);
        }
        
        return result;
    }
    
    public List<TrainingEndpoint> GetAllEndpoints()
    {
        return new List<TrainingEndpoint>{new TrainingEndpoint()};
    }
}