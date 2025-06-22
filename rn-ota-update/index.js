import React from 'react';
import { AppState, NativeModules, DevSettings } from 'react-native';

const { OTABundleManager } = NativeModules;


function checkForUpdate() {
    console.log('[DEBUG]checkForUpdate', OTABundleManager);
    OTABundleManager.checkForBundleUpdate('http://localhost:8008/updates', 'demo-app').then(isBundleUpdated => {
        console.log('[DEBUG]checkForUpdate: isBundleUpdated', isBundleUpdated);
        if (isBundleUpdated) {
            DevSettings.reload();
        }
    });
}

function onAppStateChange(nextState) {
    if (nextState === 'active') {
        checkForUpdate();
    }
}

export function initializeOTAListener() {
    AppState.addEventListener('change', onAppStateChange);
}


