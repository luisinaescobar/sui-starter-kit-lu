module starter::practica_sui {
    use std::debug::print;
    use std::string::{String, utf8};
    use sui::object::{UID, new, delete};
    use sui::tx_context::TxContext;
    use sui::vec_map::{VecMap, Self as vec_map};

 struct Principal has store { 
    id_principal: UID,
    nombre: String,
    titulo: String,
    descripcion: String,
    precio: u8,
    sintac: bool,
}
struct Postre has key, store { 
    id_postre: UID,
    nombre: String,
    titulo: String,
    descripcion: String,
    precio: u8, 
    sintac: bool,
}
struct Entrada has key, store { 
    id_entrada: UID,
    nombre: String,
    titulo: String,
    descripcion: String,
    precio: u8, 
    sintac: bool,
}
struct Menu has key, store { 
    id: UID,
    entradas: Entrada,
    principales: Principal,
    postres: Postre,
} 
       #[error]
    const YA_EXISTE_PRINCIPAL: vector<u8> = b"Ya existe el principal, por favor intente con otro";
     #[error]
    const YA_EXISTE_ENTRADA: vector<u8> = b"Ya existe el entrada, por favor intente con otro";
     #[error]
    const YA_EXISTE_POSTRE: vector<u8> = b"Ya existe el postre, por favor intente con otro";
     #[error]
    const NO_EXISTE_PRINCIPAL: u16 = 404;

    public fun crear_menu(nombre: String, ctx: &mut TxContext) {
        let menu = Menu {
            id: object::new(ctx),
            entradas: vec_map::empty(),
            principales: vec_map::empty(),
            postres: vec_map::empty(),
        };
        transfer::transfer(menu, tx_context::sender(ctx));
    }

    public fun registrar_principal(menu: &mut Menu, id_principal: u64) {
        assert!(menu.principales.contains(&id_principal), YA_EXISTE_PRINCIPAL);
        let principal = Principal {
            id_principal,
            nombre,
            titulo,
            descripcion,
            precio,
            sintac
        };
        menu.principales.insert(id_principal, principal);
    }
    public fun eliminar_principal(menu: &mut Menu, id_principal: u64) {
        assert!(menu.principales.contains(&id_principal), NO_EXISTE_PRINCIPAL);
        menu.principal.remove(&id_principal);
    }
    public fun registrar_entrada(menu: &mut Menu, id_entrada: u64) {
        assert!(menu.entradas.contains(&id_entrada), YA_EXISTE_ENTRADA);
        let entrada = Entrada {
            id_entrada,
            nombre,
            titulo,
            descripcion,
            precio,
            sintac
        };
        menu.entradas.insert(id_entrada, entrada);
    }
    public fun registrar_postre(menu: &mut Menu, id_postre: u64) {
        assert!(menu.postres.contains(&id_postre), YA_EXISTE_POSTRE);
        let postre = Postre {
            id_postre,
            nombre,
            titulo,
            descripcion,
            precio,
            sintac
        };
        menu.postres.insert(id_postre, postre);
    }
    public fun actualizar_principal(
        menu: &mut Menu, 
        id_principal: u64, 
        nombre: String,
        titulo: String,
        descripcion: String,
        precio: u8, 
        sintac: bool,){
            assert!(menu.principales.contains(&id_principal), NO_EXISTE_PRINCIPAL);
            let principal = menu.principales.get_mut(&id_principal);
            principal.nombre = nuevo_nombre;
            principal.titulo = nuevo_titulo;
            principal.descripcion = nueva_descripcion;
        }
}