@IsTest
public class TrainingFixtures {

    public static TrainingPath GetPath(Integer stepCount)
    {
        TrainingPath path=new TrainingPath();
        path.Name='Mock Path';
        path.summary='Mock path';
        path.namespace='MO';
        for (Integer idx=0; idx<stepCount; idx++)
        {
            TrainingPath.TrainingStep step=new TrainingPath.TrainingStep();
            step.id=''+idx;
            step.name=path.name + ' step ' + (idx+1);
            step.description='Mock step';
            if (idx<3) {
                step.complete=true;
            }
            path.steps.add(step);
        }

        return path;
    }

    public static TrainingUserInfo GetUserInfo(Integer badgeCount)
    {
        TrainingUserInfo info=new TrainingUserInfo();
        info.email='test@test.com';
        info.firstname='Unit';
        info.lastname='Test';
        info.initials='UT';
        info.points=10000;
        info.badgeCount=5;
        for (Integer idx=0; idx<badgeCount; idx++)
        {
            TrainingUserInfo.UserBadge ub=new TrainingUserInfo.UserBadge();
            ub.name='Test Badge ' + idx;
            ub.description='Test Badge ' + idx;
            ub.whenEarned=System.now().addHours(-idx);
            info.badges.add(ub);
        }

        return info; 
    }
}
