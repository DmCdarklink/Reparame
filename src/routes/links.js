const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');
const { regiones } = require('./../regiones');

router.get('/add/:id_proveedor', isLoggedIn, async (req, res) => {
    const { id_proveedor } = req.params;
    const proveedor = await pool.query('SELECT * FROM rep_datosproveedor WHERE id_proveedor =?', [id_proveedor])
    console.log(proveedor[0])
    res.render('links/add',{proveedor: proveedor[0]});
});

router.get('/regiones', isLoggedIn, (req, res) => {
    res.render('links/regiones')

});

router.post('/add', isLoggedIn, async (req, res) => {
   
    const { Fecha_Solicitud, Titulo_Servicio, Descripcion_Solicitud, Region_Servicio, Comuna_Servicio, Calle_Servicio, numero_calle, id_proveedor} =req.body;
    const newLink = {
        Fecha_Solicitud,
        Titulo_Servicio, 
        Descripcion_Solicitud, 
        Region_Servicio, 
        Comuna_Servicio, 
        Calle_Servicio,
        numero_calle,
        Estado_Solicitud: 1,
        Indice_Usuario: req.user.Id_Usuario,
        id_proveedor
    };
    console.log(newLink);
    pool.query('INSERT INTO rep_solicitudservicio set?', [newLink]);
    
    req.flash('success', 'Solicitud enviada correctamente');
    res.redirect('/links/pendientes');
});

//ruta que indica las solicitudes pendientes de cada cliente
router.get('/pendientes', isLoggedIn, async (req, res) => {
    const solicitudes = await pool.query('SELECT * FROM rep_solicitudservicio WHERE Indice_Usuario = ?', [req.user.Id_Usuario]);
    const links = []
    for (let i = 0; i < solicitudes.length; i++) {
        if (solicitudes[i].estado === null) {
            links.push(solicitudes[i])
        }
    }
    
    res.render('links/list', {links});

});

//ruta para almacenar las solicitudes aceptadas del cliente
router.get('/aceptadas', isLoggedIn, async (req, res) => {
    const solicitudes = await pool.query('SELECT * FROM rep_solicitudservicio WHERE Id_Usuario = ?', [req.user.Id_Usuario]);
    const links = []
    for (let i = 0; i < solicitudes.length; i++) {
        if (solicitudes[i].estado === 1) {
            links.push(solicitudes[i])
        }
    }
    
    res.render('links/list', {links});

});

//ruta para almacenar solicitudes recibidas por cada tecnico que publique sus servicios
router.get('/recibidas', async(req, res, next)=>{
    const recibidas = await pool.query('SELECT * FROM rep_solicitudservicio WHERE Id_proveedor = ?', [req.user.Id_Usuario]);
    
    res.render('links/tecnicoRecibidas',{ recibidas })
})


router.get('/delete/:Indice_Solicitud', async (req, res) => {
    const { Indice_Solicitud } = req.params;
    await pool.query('DELETE FROM rep_solicitudservicio WHERE Indice_Solicitud = ?', [Indice_Solicitud]);
    req.flash('success', 'Solicitud cancelada correctamente');
    res.redirect('/links');
});

router.get('/initsearch', isLoggedIn, (req, res) => {
    res.render('links/initsearch');
});

router.get('/search/:Tipo_Servicio', async (req, res) => {
    const { Tipo_Servicio } = req.params;
    const search = await pool.query('Select * FROM rep_datosproveedor WHERE Tipo_servicio = ?', [Tipo_Servicio]);
    req.flash('success', 'Se encontraron los siguientes datos');
    for (let i = 0; i < search.length; i++) {
        const valoracion = search[i].Valoracion
        const rating = []
        for (let i = 0; i < 5; i++) {
            if (i < valoracion) {
                rating[i] = "checked"
            } else {
                rating[i] = ""
            }
        }
        search[i].rating = rating
    }


    console.log(search);
    res.render('links/search', { search });
});

router.get('/details/:Indice_Solicitud', isLoggedIn, async (req, res) => {
    const {Indice_Solicitud} = req.params;
    const solicitud = await pool.query(`SELECT * FROM rep_solicitudservicio
    INNER JOIN rep_datosproveedor ON rep_solicitudservicio.Id_proveedor = rep_datosproveedor.id_proveedor
    WHERE rep_solicitudservicio.Indice_Solicitud = ${Indice_Solicitud}` );
    console.log(solicitud)


    
    res.render('links/details', {solicitud : solicitud [0]});
});

router.get('/details_tec/:Solicitud_Tecnico', isLoggedIn, async (req, res) => {
    const { Solicitud_Tecnico } = req.params;
    const sol_usu = await pool.query(`SELECT * FROM rep_solicitudservicio
    INNER JOIN rep_datosusuario ON rep_solicitudservicio.Indice_Usuario = rep_datosusuario.Id_Usuario
    WHERE rep_solicitudservicio.Indice_Solicitud = ${Solicitud_Tecnico}`);
    console.log(sol_usu)

    res.render('links/details_tec', { sol_usu: sol_usu[0] });
});




module.exports = router; 