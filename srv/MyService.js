const MyService = function(srv){
    srv.on('somesrv', (req,res) => {
        return "Hey There, welcome to CAPM" ;
    });
}

module.exports = MyService;