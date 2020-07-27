const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');
const { validate, clean, format } = require('rut.js');

passport.use('local.signin', new LocalStrategy({
    usernameField: 'Email',
    passwordField: 'Password',
    passReqToCallback: true
}, async (req, Email, Password, done) =>{
    console.log(req.body);
    const rows = await pool.query('SELECT * FROM rep_datosusuario WHERE Email = ?',[Email]);
        if (rows.length > 0) {
            const user = rows [0];
            const validPassword = await helpers.matchPassword(Password, user.Password);
                if (validPassword) {
                    done(null, user, req.flash('success','Bienvenida/o ' + user.Nombres));
                    
                } else {
                    done(null, false, req.flash('message','Su contraseña no es correcta'));
                }
            
        } else {
            return done (null, false, req.flash('message','Su correo no esta registrado'));
        }
})); 


passport.use('local.signup', new LocalStrategy({
    usernameField: 'Email',
    passwordField: 'Password',
    passReqToCallback: true
}, async (req, Email, Password, done) => {
        const { Rut, Nombres, Apellidos, Telefono, tipo, Region, Comuna, Direccion } = req.body;
        let rut = "";
        if (validate(Rut)) {
            const cleanrut = clean(Rut);
            rut = format(rut);
        } else {
            done(null, false, req.flash('message', 'Su Rut no es correcto'))
        }
        if (Telefono.length != 9) {
            done(null, false, req.flash('message', 'El N° de telefono debe contener 9 caracteres'))
        }

    const newUser = {
        Email: Email,
        Password,
        Rut : rut,
        Nombres,
        Apellidos,
        Telefono,
        Tipo_Usuario:tipo,
        Region,
        Comuna,
        Direccion
    };
    newUser.Password = await helpers.encryptPasswords(Password);
    const result = await pool.query('INSERT INTO rep_datosusuario SET ?', [newUser]);
    newUser.Id_Usuario = result.insertId;
    return done(null, newUser);
    
}));

passport.serializeUser((user, done) => {
    done(null, user.Id_Usuario);

});

passport.deserializeUser(async (Id_Usuario, done) =>{
    const rows = await pool.query('SELECT * FROM rep_datosusuario WHERE Id_Usuario= ?', [Id_Usuario]);
    done(null, rows[0]);
});