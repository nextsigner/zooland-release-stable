import QtQuick 2.0
import "../../js/Funcs_v2.js" as JS

QtObject{
    id: r

    //-->App
    property bool dev: false
    property var j: JS
    property var ci: xApp
    property var aCi: []
    property var aCiCtrl: []
    property string res: ''
    property int fs: 20
    property int xAppMargin: 10
    //<--App

    //--> Variables Astrológicas
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta', 'asc', 'mc']
    property var planetasReferencia: ['el sol', 'la luna', 'el planeta mercurio', 'el planeta venus', 'el planeta marte', 'el planeta jupiter', 'el planeta saturno', 'el planeta urano', 'el planeta neptuno', 'pluton', 'el nodo norte', 'el nodo sur', 'el asteroide quiron', 'la luna blanca selena', 'la luna negra lilith', 'el ascendente', 'el medio cielo']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    //property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
    //<--  Variables Astrológicas

    //--> Variables SWEG
    property string tipo: 'vn'
    property string tipoBack: 'vn'
    property string cParams: '' // ex fileData
    property string cParamsBack: '' // ex fileDataBack
    property bool ev: false

    property real uAscDegreeTotal
    property real currentRotationxAsSol

    property real currentAbsolutoGradoSolar
    property real currentGradoSolar
    property real currentMinutoSolar
    property real currentSegundoSolar

    property real currentAbsolutoGradoSolarBack
    property real currentGradoSolarBack
    property real currentMinutoSolarBack
    property real currentSegundoSolarBack

    property var currentDate
    property var currentDateBack
    property string currentFecha: ''
    property string currentFechaBack: ''
    property string currentLugar: ''

    //XAs
    property string uSon: ''
    property string uSonBack: ''
    property var currentXAs
    property var currentXAsBack
    property bool showPointerXAs: true
    property bool showPointerXAsBack: true


    //<-- Variables SWEG

    //--> Variables de Estado
    property bool capturing: false

    //<-- Variables de Estado

    //--> Variables de Numerología
    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']
    //<-- Variables de Numerología

    onCParamsChanged:{
        let j=JSON.parse(cParams)
        //ñalskdfjñla
        //log.lv('getZoolandData(j)...')
        let aL=[]
        aL.push(''+j.params.n)
        aL.push(''+j.params.d+'/'+j.params.m+'/'+j.params.a)
        aL.push(''+j.params.h+':'+j.params.min+'hs')
        aL.push('<b>GMT:</b> '+j.params.gmt)
        aL.push('<b>Ubicación:</b> '+j.params.ciudad)
        aL.push('<b>Lat:</b> '+parseFloat(j.params.lat).toFixed(2))
        aL.push('<b>Lon:</b> '+parseFloat(j.params.lon).toFixed(2))
        aL.push('<b>Alt:</b> '+j.params.alt)
        let tipo=j.tipo
        let strSep=''
        if(tipo==='vn'){
            strSep='Carta Natal'
        }
        if(tipo==='sin'){
            strSep='Sinastría'
        }
        if(tipo==='rs')strSep='Rev. Solar '+va
        if(tipo==='trans')strSep='Tránsitos'
        if(tipo==='dirprim')strSep='Dir. Primarias'
        zoolDataView.setDataView(strSep, aL, [])
        //zpn.addNot(cParams, true, 5000)
    }
    onCParamsBackChanged:{
        let j=JSON.parse(cParamsBack)
        //ñalskdfjñla
        //log.lv('getZoolandData(j)...')
        let aL=zoolDataView.atLeft
        let aR=[]
        aR.push(''+j.params.n)
        aR.push(''+j.params.d+'/'+j.params.m+'/'+j.params.a)
        aR.push(''+j.params.h+':'+j.params.min+'hs')
        aR.push('<b>GMT:</b> '+j.params.gmt)
        aR.push('<b>Ubicación:</b> '+j.params.ciudad)
        aR.push('<b>Lat:</b> '+parseFloat(j.params.lat).toFixed(2))
        aR.push('<b>Lon:</b> '+parseFloat(j.params.lon).toFixed(2))
        aR.push('<b>Alt:</b> '+j.params.alt)
        let tipo=j.tipo
        let strSep=''
        if(tipo==='vn'){
            strSep='Carta Natal'
        }
        if(tipo==='sin'){
            strSep='Sinastría'
        }
        if(tipo==='rs')strSep='Rev. Solar '+va
        if(tipo==='trans')strSep='Tránsitos'
        if(tipo==='dirprim')strSep='Dir. Primarias'
        zoolDataView.setDataView(strSep, aL, aR)
        //zpn.addNot(cParams, true, 5000)
    }


    /*
    property var ci: xApp


    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    property string version: '0.0.-1'
    property string sweBodiesPythonFile: 'astrologica_swe_v2.py'
    property var j: JS

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+unik.getPath(4)+'/Python/python.exe'+'"'

    property string pythonLocation: ''

    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string mod: 'vn'

    property bool backIsSaved: false

    property var objInFullWin
    property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500

    property var minymaClient
    property var objZoolFileExtDataManager
    property var aExtsIds: []

    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''

    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1

    property int currentHouseIndex: -1
    property int currentHouseIndexBack: -1

    property int currentSignIndex: 0

    property date currentDate
    property string currentNom: ''
    property string currentFecha: ''
    property string currentLugar: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentGradoSolar: -1
    property int currentRotationxAsSol: -1
    property int currentMinutoSolar: -1
    property int currentSegundoSolar: -1
    property real currentGmt: 0
    property real currentLon//: 0.0
    property real currentLat//: 0.0
    property real currentAlt: 0

    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false
    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    //property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    //property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'asc', 'mc']


    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    //property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    //property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Gauquelin', 'Morinus']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']

                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus


    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1
    //property string stringRes: "Res"+Screen.width+"x"+Screen.height

    property var cmd
    property bool ev: false //Exterior Visible

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property bool sspEnabled: false

    property var aParams: ['{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo", "d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934,"ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}', '{"params":{"tipo":"vn","ms":1622602994892,"n":"Natalia S. Pintos", "d":8, "m":9, "a":1980, "h":17,"min":0, "gmt":-3, "lat":-34.769249, "lon":-58.6480318, "ciudad":"Gonzalez Catán Buenos Aires Argentina", "msmod":1680626575611}}', '{"params":{"tipo":"vn","ms":1622602707398,"n":"Nico","d":3,"m":11,"a":2000,"h":1,"min":45,"gmt":-3,"lat":-34.7047876,"lon":-58.5861609,"ciudad":"Isidro Casanova Buenos Aires Argentina","msmod":1680658423514}}', '{"params":{"tipo":"vn","ms":1657287434162,"n":"Hugo_13-45hs","d":1,"m":11,"a":1963,"h":13,"min":45,"gmt":-3,"lat":-34.6075682,"lon":-58.4370894,"ciudad":"Ciudad de Buenos Aires Argentina","msmod":1657287598347}}', '{"params":{"tipo":"vn","ms":1684454531469,"n":"Mario_Eduardo_Pizarro","d":3,"m":1,"a":1972,"h":9,"min":30,"gmt":-3,"lat":-34.6075682,"lon":-58.4370894,"alt":0,"ciudad":"Ciudad de Buenos Aires Argentina","hsys":"P","shared":false,"extId":"id_3_1_1972_9_30_-3_-34.6075682_-58.4370894_0_vn_P"}}']


    */

}
