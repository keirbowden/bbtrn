({
    toggleTiles: function (cmp, ev) {
        cmp.set('v.displayAsTiles', !cmp.get('v.displayAsTiles'));
    },
    toggleInfo: function(cmp, ev) {
        cmp.set('v.infoVisible', !cmp.get('v.infoVisible'));
    },
    toggleShowCompleted: function(cmp, ev) {
        cmp.set('v.showCompleted', !cmp.get('v.showCompleted'));
    }
})