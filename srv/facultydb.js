const cds = require('@sap/cds');
function cald(code){
    var gender_description ;
    if(code === 'M'){
        gender_description = "Male";
    }else{
        gender_description = "Female";
    } 
    return gender_description;
}


module.exports = cds.service.impl(function () {

    const { Faculty,Gender } = this.entities();


    this.before(['CREATE'], Faculty,async(req) => {
        gender_description= cald(req.data.gender);
        req.data.gender= gender_description;
        let query1 = SELECT.from(Faculty).where({ref:["acc_num"]}, '=', {val: req.data.acc_num});
        result = await cds.run(query1);
        if(result.length>0) {
            req.error ({'code': 'AJAY',message:'faculty with same account number are not allowed'});
        }

    });

    this.on('READ',Gender,async(req) => {

        genders = [
            {"code":"M", "description":"Male"},
            {"code":"F", "description":"Female"}
        ]
        genders.$count = genders.length;
        return genders;
    });


});