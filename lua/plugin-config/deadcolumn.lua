local opts = {
    scope = 'line',
    modes = { 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
    blending = {
        threshold = 0.75,
        colorcode = '#87CEEB',
        hlgroup = {
            'Normal',
            'background',
        },
    },
    warning = {
        alpha = 0.4,
        colorcode = '#DDA0DD', 
        hlgroup = {
            'Error',
            'background',
        },
    },
}

require('deadcolumn').setup(opts) -- Call the setup function
