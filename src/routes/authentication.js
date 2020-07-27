const express = require('express');
const router = express.Router();
const passport = require('passport');
const { isLoggedIn } = require('../lib/auth');
const { isNotLoggedIn } = require('../lib/auth');

const pool = require('../database');
const { regiones } = require('./../regiones');

const { request } = require('express');

router.get('/signup', isNotLoggedIn, async (req, res) => {
    const tipo = await pool.query('SELECT * FROM rep_tipousuario');
    
    res.render('auth/signup', { tipo, regiones });
});



router.post('/signup', passport.authenticate('local.signup', {
    successRedirect: '/profile',
    failureRedirect: '/signup',
    failureFlash: true
}));

router.get('/signin', isNotLoggedIn, (req, res) => {
    res.render('auth/signin');
});

router.post('/signin', (req, res, next) => {

    passport.authenticate('local.signin', {
        successRedirect: '/profile',
        failureRedirect: '/signin',
        failureFlash: true

    })(req, res, next);
});

router.get('/profile', isLoggedIn, async (req, res) => {
    const tipoUsuario = req.user.Tipo_Usuario
    //Este condicional filtra entre perfil de tecnicos y clientes
    if (tipoUsuario === 1) {
        res.render('profile'); //perfil de cliente
    } else {
        const servicio = await pool.query('SELECT * FROM rep_tiposervicio');
        res.render('profileTec', { servicio }); //perfil tecnico
    }

});

//Ruta para cerrar sesion
router.get('/logout', isLoggedIn, (req, res) => {
    req.logOut();
    req.flash('success', 'Ha cerrado su sessión con éxito')
    res.redirect('/signin');
});

//ruta para postear servivios del tecnico
router.post('/agregarPost', async (req, res, next)=>{
    const { Nombre_Negocio, Telefono_Negocio, Descripcion_Negocio, Tipo_Servicio } = req.body
    if (Telefono_Negocio.length != 9) {
        done(null, false, req.flash('message', 'El N° de telefono debe contener 9 caracteres'))
    }
    const post = {
        id_proveedor: req.user.Id_Usuario,
        Nombre_Negocio,
        Telefono_Negocio,
        Descripcion_Negocio,
        Tipo_Servicio,
        Valoracion: 5
    }

    await pool.query('INSERT INTO rep_datosproveedor SET ?', [post]);
    await pool.query(`UPDATE rep_datosusuario SET posted = 1 WHERE Id_Usuario = ${req.user.Id_Usuario};`)
    res.redirect('/profile')
    
})

module.exports = router;