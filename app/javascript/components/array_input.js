const initArrayInput = () => {
    let btns =  document.getElementsByClassName('array_input_btn');

    for(let btn of btns) {
        initDestructionBtnDiv(btn);
        refreshDestroyBtn(btn)
        listenAddInput (btn)
        let destroy_btns = document.querySelectorAll(`div.array_item_delete_btn[name="${btn.getAttribute('name')}"]`);
        for(let destroy_btn_id = 0; destroy_btn_id < destroy_btns.length; destroy_btn_id++) {
            deleteInput(destroy_btn_id, destroy_btns)
        }
    }

    function listenAddInput (btn) {
        btn.addEventListener('click', (event) => {
            if (btn.id == 'add_new_input') {
                addinput(btn);
            }
        });
    }
    
    function deleteInput(destroy_btn_id, destroy_btns) {
        destroy_btns[destroy_btn_id].addEventListener('click', (event) => {
            console.log(destroy_btn_id)
            destroy_btns[destroy_btn_id].parentNode.parentNode.removeChild(destroy_btns[destroy_btn_id].parentNode);
            return false;
        })
    }
    

    function addinput(btn) {
        let forms_name = btn.getAttribute('name');
        let inputs = document.querySelectorAll(`input[name="${forms_name}"]`);
        let new_input = inputs[inputs.length-1].cloneNode(true);
        new_input.setAttribute('value','')
        new_input.setAttribute('placeholder','Nouvelle entrée')
        let new_forms = document.getElementsByClassName(`${forms_name.replaceAll(']','').split('[').filter(function(el) { return el; }).join('_')}`)[0].innerHTML += new_input.outerHTML
        addDestructionBtnDiv(forms_name, btn)
    }

    function initDestructionBtnDiv(btn) {
        let forms_name = btn.getAttribute('name');
        let inputs = document.querySelectorAll(`input[name="${forms_name}"]`);
        for(let input of inputs) {
            var input_container = input.parentElement
            var above_input = document.createElement("div");
                above_input.className = 'array_item_input';
                above_input.setAttribute('name', forms_name);
            input_container.insertBefore(above_input, input)
            above_input.appendChild(input)
            var delete_btn = document.createElement("div");
                delete_btn.className = 'array_item_delete_btn';
                delete_btn.setAttribute('name', forms_name);
            above_input.appendChild(delete_btn, input)
        };
    };

    function addDestructionBtnDiv(forms_name, btn) {
        let inputs = document.querySelectorAll(`input[name="${forms_name}"]`);
        let input = inputs[inputs.length-1]
        var input_container = input.parentElement
            var above_input = document.createElement("div");
                above_input.className = 'array_item_input';
                above_input.setAttribute('name', forms_name);
            input_container.insertBefore(above_input, input)
            above_input.appendChild(input)
            var delete_btn = document.createElement("div");
                delete_btn.className = 'array_item_delete_btn';
                delete_btn.setAttribute('name', forms_name);
            above_input.appendChild(delete_btn, input)
        refreshDestroyBtn(btn);
    };

    function refreshDestroyBtn(btn) {
        var destroy_btns = document.querySelectorAll(`div.array_item_delete_btn[name="${btn.getAttribute('name')}"]`);
        for(var i = 0; i < destroy_btns.length; i++) {
            destroy_btns[i].innerHTML = '<i class="fas fa-trash-alt"></i>';
        }
    }
}

export { initArrayInput };