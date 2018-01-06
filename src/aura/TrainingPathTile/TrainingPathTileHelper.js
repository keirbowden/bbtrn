({
    clicked : function(cmp, ev) {
        var path=cmp.get('v.path');
        cmp.set('v.selectedPathId', cmp.get('v.path').pathId);
    }
})