import React, { Component } from 'react';
import ToolBar from '../../components/ToolBar/index.jsx'
import DisplayTable from '../../components/Table/index.jsx'


class HomePage extends Component {

    render() {
        return (
            <div> 
                <h3> Cargohub</h3>
                <ToolBar />
                <DisplayTable />
            </div>
        )
    }
}

export default HomePage