const cds = require('@sap/cds');

function calcAge(dob){
    var today = new Date();
    var birthDate = new Date(Date.parse(dob));    
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}

function calcDesc(code) {
    var gender_description;
    console.log(code);
    if(code === "M"){
        gender_description="Male";
    }
    else{
        gender_description="Female";
    }
    return gender_description;
    
}

module.exports = cds.service.impl(function () {

    const { Student, Gender } = this.entities();

    this.on(['READ'], Student, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)){
            results.forEach(element => {
             element.age=calcAge(element.dob); 
            });
        }else{
            results.age=calcAge(results.dob);
        }
        
        return results;
    });



    this.before(['CREATE','UPDATE'], Student, async(req) => {
        age = calcAge(req.data.dob);
        gender_description = calcDesc(req.data.gender);
        console.log(gender_description);
        req.data.gender=gender_description;
    if (age<18 || age>45){
        req.error({'code': 'WRONGDOB',message:'Student not the right age for school:'+age, target:'dob'});
    }

    let query1 = SELECT.from(Student).where({ref:["email_id"]}, "=", {val: req.data.email_id});
    if (req.data.stid) {
        query1.where({ ref: ["stid"] }, "!=", { val: req.data.stid });
    }
    result = await cds.run(query1);
    if (result.length >0) {
        req.error({'code': 'STEMAILEXISTS',message:'Student with such email already exists', target: 'email_id'});
    }

    let query2 = SELECT.from(Student).where({ref:["pan_no"]}, "=", {val: req.data.pan_no});
    if (req.data.stid) {
        query2.where({ ref: ["stid"] }, "!=", { val: req.data.stid });
    }
    result = await cds.run(query2);
    if (result.length >0) {
        req.error({'code': 'STPANNOEXISTS',message:'Student with such pan number already exists', target: 'pan_no'});
    }


    });

    this.on('READ', Gender, async(req) => {
        genders = [
            {"code":"M", "description":"Male"},
            {"code":"F", "description":"Female"}
        ]
        genders.$count=genders.length;
        return genders;
    })

});



