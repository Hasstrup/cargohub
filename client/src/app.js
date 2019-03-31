import React from 'react';
import { Route, Switch } from 'react-router-dom';
import { hot } from 'react-hot-loader'
import MainApplication from './modules/home'


// doing this incase I want to add more pages
const App = () => (
    <main> 
        <Switch> 
            <Route exact path="/" component={MainApplication}/>
        </Switch>
    </main>
)

export default hot(module)(App)