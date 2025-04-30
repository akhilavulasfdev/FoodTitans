({

getproertyDetails : function(component, event, helper) {

        var pageReference = component.get("v.pageReference");

        console.log('getproertyDetails pageReference'+JSON.stringify(pageReference));

        var pid = pageReference.state.c__propertyId;

         console.log('getproertyDetails pageReference pid'+pid);

var action = component.get('c.getDetails');

        action.setParams({

            'propId':pid

        });

        action.setCallback(this,function(response){

        var state = response.getState();

            var responseValue= response.getReturnValue();

            component.set('v.property',responseValue);

             component.set('v.propertyFound',true);

        });

        $A.enqueueAction(action,false);

}

})