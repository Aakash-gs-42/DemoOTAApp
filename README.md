
<img width="846" alt="Screenshot 2025-06-22 at 3 44 25 PM" src="https://github.com/user-attachments/assets/bd2dffa5-f9a8-456f-b93f-439fe7c7660a" />

- The native method OTABundleManager (in branch v-1.0.0) is invoked from JavaScript when the app enters the active state. This native method then makes a request to the server.
- If the bundleHashCode returned by the server does not match the current bundleHashCode, a native API call is made to fetch the updated bundle from R2 storage
- Then RN bridge is reloaded

CLI For OTA:

Repo - 

The CLI allows you to push a JavaScript bundle to R2 storage in CloudStorage.

Supported flags:
--platform
--app-id
--input-path

Notes:
- If the platform is iOS, the uploaded bundle file will have the extension: .ios-bundle.jsbundle
- If the platform is Android, the uploaded bundle file will have the extension: .android-bundle.jsbundle

OTA Server:

Repo - https://github.com/Aakash-gs-42/go-ota-server

This is a Go-based server that supports two primary routes for Over-The-Air (OTA) updates.

Available Endpoints:

| **Endpoint** | **Method** | **Description** | **Body Parameters** |
|--------------|------------|------------------|----------------------|
| `/updates`   | POST       | Returns metadata information for a given app. | `appId` (string), `platform` (string) — e.g., `ios` or `android` |
| `/bundle`    | POST       | Returns the JavaScript bundle for the specified app and platform. | `appId` (string), `platform` (string) — e.g., `ios` or `android` |

