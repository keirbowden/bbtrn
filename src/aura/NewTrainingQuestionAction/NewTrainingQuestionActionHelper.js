({
    init : function(cmp, ev) {
        try{

        this.showWorking(cmp);
        cmp.set('v.simpleNewQuestion.sobjectType', 'Training_Question__c');
        cmp.set("v.simpleNewQuestion.Training_Step__c", cmp.get("v.recordId"));
        cmp.find("questionRecordCreator").saveRecord(function(saveResult) {
            alert('in callback');
            var resultsToast = $A.get("e.force:showToast");
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                // record is saved successfully
                resultsToast.setParams({
                    "type": "success",
                    "title": "Saved",
                    "message": "The record was saved."
                });

	            var evt = $A.get("e.force:navigateToSObject");
    	        if (evt) {
        		    evt.setParams({
            			"recordId" : saveResult.recordId
            		});
	        	evt.fire();
    	    }
            } else if (saveResult.state === "INCOMPLETE") {
                // handle the incomplete state
                resultsToast.setParams({
                    "type": "error",
                    "title": "Save Failed",
                    "message": "User is offline, device doesn't support drafts."
                });
            } else if (saveResult.state === "ERROR") {
                // handle the error state
                resultsToast.setParams({
                    "type": "error",
                    "title": "Save Failed",
                    "message": 'Problem saving contact, error: ' + JSON.stringify(saveResult.error)
                });
            } else {
                resultsToast.setParams({
                    "type": "error",
                    "title": "Save Failed",
                    "message": 'Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error)
                });
            }
            resultsToast.fire();
        });    
    }
    catch (e)
    {
        alert('Exception ' + e.message);
    }
    }
})
