# rhasspy-IBMWatson
Simple shell script to use *Watson* ([IBM's cloud TTS service](https://cloud.ibm.com/catalog/services/text-to-speech)) in [Rhasspy](https://github.com/rhasspy/rhasspy)

Based on the [jarvis_says.sh](https://github.com/tschmidty69/homeassistant-config/blob/master/snips/jarvis_says.sh) script from [tschmidty69](https://github.com/tschmidty69)'s Home Assistant config (his was for Snips and used Amazon Polly TTS) with help from this [thread](https://community.rhasspy.org/t/custom-text-to-speech/1187)
 on the Rhasspy forums
 
 Runs only on Rhasspy **2.5.11** or later
 
## Preparation
1. Create an account on IBM Cloud and register for the TTS lite plan here: https://cloud.ibm.com/catalog/services/text-to-speech
- Use the closest location
- You can change the service name
- Keep the defaults otherwise
> The lite (free) plan includes 10 000 characters/month which is plenty for personal home use
 
> However, there is a 30 day inactivity limit so simply make sure to request some **different** commands (text to be spoken) once every so often
2. In your dashboard find your service (Menu in top left corner -> Ressource list -> Services and software -> Text to speech)
3. Note your apikey and url

## Easy Installation

1. Run `wget https://raw.githubusercontent.com/Rayz224/rhasspy-IBMWatson/main/install.sh`
2. Make the install script executable: `chmod a+x install.sh`
3. Run the script with sudo `sudo ./install.sh`
> Theses commands can be dangerous because they executes a script from the internet with sudo (root access) so make sure to always check the script before executing them. 
> In this case, the script that is run is [install.sh](https://github.com/Rayz224/rhasspy-IBMWatson/blob/main/install.sh), I suggest you verify it before running the command.
> If you do not trust the installation script, follow the manual installation below
4. Follow the instructions in the installation script
- For a complete list of the voices availables see https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices#listVoices
5. Update the Rhasspy TTS settings to Local Command and set Say Program to: `/profiles/en/rhasspy_watson_says.sh` or `/home/${USER}/.config/rhasspy/profiles/en/rhasspy_watson_says.sh` for non-docker users
## Manual Installation
1. Copy the [rhasspy_watson_says.sh](https://github.com/Rayz224/rhasspy-IBMWatson/blob/main/rhasspy_watson_says.sh) file inside your rhasspy profile folder (rhasspy/profiles/en/)
2. Update the apikey, url, voice and cache variables 
- apikey = Your IBM apikey
- url = Your IBM url
- voice = The IBM voice to use (see https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices#listVoices for a complete list) (Example: `en-GB_JamesV3Voice`)
- cache = the path to the cache folder (For docker users: `/profiles/en/tts/cache/`) (For non-docker users: `/home/${USER}/.config/rhasspy/profiles/en/tts/cache/`)
3. Make the script executable: `chmod a+x /home/${USER}/.config/rhasspy/profiles/en/rhasspy_watson_says.sh` (you might have to run with sudo)
4. Update the Rhasspy TTS settings to Local Command and set Say Program to: `/profiles/en/rhasspy_watson_says.sh` or `/home/${USER}/.config/rhasspy/profiles/en/rhasspy_watson_says.sh` for non-docker users
