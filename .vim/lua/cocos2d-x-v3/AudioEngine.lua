--Encapsulate SimpleAudioEngine to AudioEngine,Play music and sound effects.
local AudioEngine = {}

function AudioEngine.stopAllEffects()
    cc.SimpleAudioEngine:getInstance():stopAllEffects()
end

function AudioEngine.getMusicVolume()
    return cc.SimpleAudioEngine:getInstance():getMusicVolume()
end

function AudioEngine.isMusicPlaying()
    return cc.SimpleAudioEngine:getInstance():isMusicPlaying()
end

function AudioEngine.getEffectsVolume()
    return cc.SimpleAudioEngine:getInstance():getEffectsVolume()
end

function AudioEngine.setMusicVolume(volume)
    cc.SimpleAudioEngine:getInstance():setMusicVolume(volume)
end

function AudioEngine.stopEffect(handle)
    cc.SimpleAudioEngine:getInstance():stopEffect(handle)
end

function AudioEngine.stopMusic(isReleaseData)
    local releaseDataValue = false
    if nil ~= isReleaseData then
        releaseDataValue = isReleaseData
    end
    cc.SimpleAudioEngine:getInstance():stopMusic(releaseDataValue)
end

function AudioEngine.playMusic(filename, isLoop)
    local loopValue = false
    if nil ~= isLoop then
        loopValue = isLoop
    end
    cc.SimpleAudioEngine:getInstance():playMusic(filename, loopValue)
end

function AudioEngine.pauseAllEffects()
    cc.SimpleAudioEngine:getInstance():pauseAllEffects()
end

function AudioEngine.preloadMusic(filename)
    cc.SimpleAudioEngine:getInstance():preloadMusic(filename)
end

function AudioEngine.resumeMusic()
    cc.SimpleAudioEngine:getInstance():resumeMusic()
end

function AudioEngine.playEffect(filename, isLoop)
    local loopValue = false
    if nil ~= isLoop then
        loopValue = isLoop
    end
    return cc.SimpleAudioEngine:getInstance():playEffect(filename, loopValue)
end

function AudioEngine.rewindMusic()
    cc.SimpleAudioEngine:getInstance():rewindMusic()
end

function AudioEngine.willPlayMusic()
    return cc.SimpleAudioEngine:getInstance():willPlayMusic()
end

function AudioEngine.unloadEffect(filename)
    cc.SimpleAudioEngine:getInstance():unloadEffect(filename)
end

function AudioEngine.preloadEffect(filename)
    cc.SimpleAudioEngine:getInstance():preloadEffect(filename)
end

function AudioEngine.setEffectsVolume(volume)
    cc.SimpleAudioEngine:getInstance():setEffectsVolume(volume)
end

function AudioEngine.pauseEffect(handle)
    cc.SimpleAudioEngine:getInstance():pauseEffect(handle)
end

function AudioEngine.resumeAllEffects(handle)
    cc.SimpleAudioEngine:getInstance():resumeAllEffects()
end

function AudioEngine.pauseMusic()
    cc.SimpleAudioEngine:getInstance():pauseMusic()
end

function AudioEngine.resumeEffect(handle)
    cc.SimpleAudioEngine:getInstance():resumeEffect(handle)
end

function AudioEngine.getInstance()
    return cc.SimpleAudioEngine:getInstance()
end

function AudioEngine.destroyInstance()
    return cc.SimpleAudioEngine:destroyInstance()
end

return AudioEngine

