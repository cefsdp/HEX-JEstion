const initDropdown = () => {
    const drop_btn = document.getElementsByClassName('dropbtn');
    var overlay = document.getElementById('background_overlay');

    

    for(let i = 0; i < drop_btn.length; i++) {
        drop_btn[i].addEventListener('click', (event) => {
            let button_id = drop_btn[i].id;
            let modal = document.querySelector(`.drop_content#${button_id}`);
            modal.classList.add('dropdown_active');
            overlay.style.display = 'block';
        })
    }

    overlay.addEventListener('click', (event) => {
        let popups = document.getElementsByClassName('dropdown_active');
        for(let i = 0; i < popups.length; i++) {
            popups[i].classList.remove('dropdown_active');
        }
        overlay.style.display = 'none';
    })


}

export { initDropdown };