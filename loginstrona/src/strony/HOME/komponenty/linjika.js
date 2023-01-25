import React,{useEffect,useState} from "react";
import styl from "./linjika_style.module.css";
import zdj from "../../../pliki/popo.jpg";
import { useNavigate } from "react-router";

function Linjika(props){

    const navigate=useNavigate();

    return(
        <div className={styl.styl_linjiki}>
            {/* <div className={styl.styl_paska}/> */}
            <img src={props.miniaturka} className={styl.styl_zdj}/>
            
            <p className={styl.styl_tekst1}>{props.tytul}</p>
            
            <p className={styl.styl_tekst1}>{props.data} </p>
            
            <p className={styl.styl_tekst1}>{props.rozmiar}</p>
            
            <p className={styl.styl_tekst1}>{props.autor}</p>
            
            <button className={styl.styl_przycisk} 
            onClick={() => {
            navigate(`/gallery/${props.klucz}`)
            }}>Wejdź 
            </button>
            {/* <div className={styl.styl_paska}/> */}
        </div>
    )
}

export default Linjika