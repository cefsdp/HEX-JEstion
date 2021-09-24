const initHEXModal = () => {
    const open_btns = document.getElementsByClassName('modal-button');
    const close_btns = document.getElementsByClassName('modal-close');

    for(let i = 0; i < open_btns.length; i++) {
        open_btns[i].addEventListener('click', (event) => {
            let button_id = open_btns[i].id
            let modal = document.querySelector(`.hex_modal#${button_id}`)
            modal.classList.add('hex_modal_active')
        })
    }

    for(let z = 0; z < close_btns.length; z++) {
        close_btns[z].addEventListener('click', (event) => {
            let button_id = close_btns[z].id
            let modal = document.querySelector(`.hex_modal#${button_id}`)
            modal.classList.remove('hex_modal_active')
        })
    }


}

export { initHEXModal };