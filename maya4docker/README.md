All of this guide must be done inside the `maya4docker` folder, not inside the repository root.

1. Download Maya 2026.3 and unzip it in this folder. The folder should be named `Autodesk_Maya_2026_3_Update_Linux_64bit`
2. Download the 1.18.1 version of the Autodesk Licensing Service and unzip it in this folder. The folder should be called `AdskIdentityManager-UCT-Installer`
3. Download the 16.2.0.15195 version of the Autodesk Licensing Service and place the `.rpm` file in this folder. It should be called `adsklicensing16.2.0.15195-0-0.x86_64.rpm`
4. Run the `on_host.sh` script. It does two things: set up X11 permissions for the Docker container to access the display, and register the Autodesk Licensing protocol handler so you can sign in with the host's browser.
   ```bash
   chmod +x on_host.sh
   ./on_host.sh
   ```
5. Copy the `.env.example` file into a new `.env` file and fill it according to the instructions inside.
6. Start the container with the script `run.sh`:
   ```bash
   chmod +x ./run.sh
   ./run.sh
   ```
7. Login normally and you are ready to go!
