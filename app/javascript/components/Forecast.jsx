import React, { Component, useState } from "react";
import axios from 'axios'
import { func } from "prop-types";

export default function Forecast(props) {
    const [data, setData] = useState(1)
    const [error, setError] = useState('')
    const [address, setAddress] = useState('')
    // 1775 Milmont Dr , Milpitas, CA,  95035"
    
    const apiCall =  ()=> {
      axios.get("/api/forecasts?address="+ address).then(result=> {
        console.log("@@@ RES", result)
        setData(result.data)
        setAddress()
      }).catch(err=> {
        resetData()
        setError(err.response.data.message)
        console.log("errr", err.response.data.message)
      })
    }

    const resetData =  ()=> {
      setData()
      setError()
      setAddress()
      document.getElementById("address").value = ""
    }

    return <div className="container">
      <form>
      <div class="form-group row">
      <input type="text" className="form-group form-control"  value={address} id="address" onChange={(event)=> setAddress(event.target.value)}/> 
      <button type="button" className="btn btn-primary mb-2" onClick={()=> apiCall()}>Send</button>
      <button type="reset" className="btn btn-secondary mb-2" onClick={()=> resetData()}>Reset</button>
        <ExpireData err={error}/>
        <Current data={data}/>
        <MaxMin data={data}/>
        <Location data={data}/>
        <Table data={data}/>
        </div>
      </form>
      </div>
}

function ExpireData(props){
  return props.err ? <p><b>{props?.err}</b></p> : null
}

function Location(props) {
  return props.data?.location ? <p class="h5">Location : {props?.data?.location?.name} , {props?.data?.location?.region} </p>: null
}


function Current(props) {
  return props.data?.current ? <p class="h5">Current : {props?.data?.current?.temp_f} F</p>: null
}

function MaxMin(props) {
  return props.data?.max_min ? <p class="h5">Max :{props?.data?.max_min?.maxtemp_f} F - Min : {props?.data?.max_min?.mintemp_f} F</p> : null
}

function Table(props) {
  return props.data?.hours ? <center>Hours : <table> {props?.data?.hours?.map(hour=> <tr id={hour.time}><td>{hour.time} - {hour.temp_f} F</td></tr>)}</table></center> : null
} 


