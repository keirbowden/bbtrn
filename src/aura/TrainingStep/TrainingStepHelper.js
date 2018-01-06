({
    startStep : function(cmp, ev) {
        var step=cmp.get('v.step');
        cmp.set('v.selectedStepId', step.id);
    }
})