trigger CandidatePath_au on Candidate_Path__c (before update) {
    BadgeUtils.AssignBadgeIfPathComplete(Trigger.new);
}