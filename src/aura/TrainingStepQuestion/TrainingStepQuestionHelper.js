({
    answerClicked : function(cmp, ev) {
        var answerIdx=ev.currentTarget.dataset.answeridx;
        var question=cmp.get('v.question');
        question.selectedAnswerId=answerIdx;
        for (var idx=0; idx<question.answers.length; idx++) {
            var answer=question.answers[idx];
            if (answer.idx==question.selectedAnswerId) {
                answer.state='chosen';
            }
            else {
                answer.state='';
            }
        }
        cmp.set('v.question', question);
    }
})