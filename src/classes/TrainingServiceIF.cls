public interface TrainingServiceIF {
    // Gets all the paths even if the user has completed them
    List<TrainingPath> GetAllPaths(String epName, String runAsEmail);

    // Gets the details of a single path, including a high level
    // view of the steps
    TrainingPath GetPath(String epName, String pathIdStr, String runAsEmail);

    // Gets the details of a step, including the questions
    // and answers
    TrainingPath GetStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail);

    // Marks a user as having passed a step. If this means that
    // the user has passed the path, returns true
    TrainingResult PassStep(String epName, String pathIdStr, String stepIdStr, String runAsEmail);
    
    // Marks a user as having failed a step which neans they have to wait to try again
    TrainingPath FailStepAndWait(String epName, String pathIdStr, String stepIdStr, String runAsEmail);
    
    // Gets the user infomation, such as badges, points etc
    TrainingUserInfo GetUserInfo(String epName, String runAsEmail);

    // retrieves all defined endpoints. 
    List<TrainingEndpoint> GetAllEndpoints();
}