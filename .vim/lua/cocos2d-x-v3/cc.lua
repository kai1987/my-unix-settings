require "CocoStudio"

cc = cc or {}

cc.DIRECTOR_PROJECTION_2D = 0
cc.DIRECTOR_PROJECTION_3D = 1

function cc.clampf(value, min_inclusive, max_inclusive)
    -- body
    local temp = 0
    if min_inclusive > max_inclusive then
        temp = min_inclusive
        min_inclusive =  max_inclusive
        max_inclusive = temp
    end

    if value < min_inclusive then
        return min_inclusive
    elseif value < max_inclusive then
        return value
    else
        return max_inclusive
    end
end

--Point
function cc.p(_x,_y)
    if nil == _y then
         return { x = _x.x, y = _x.y }
    else
         return { x = _x, y = _y }
    end
end

function cc.pAdd(pt1,pt2)
    return {x = pt1.x + pt2.x , y = pt1.y + pt2.y }
end

function cc.pSub(pt1,pt2)
    return {x = pt1.x - pt2.x , y = pt1.y - pt2.y }
end

function cc.pMul(pt1,factor)
    return { x = pt1.x * factor , y = pt1.y * factor }
end

function cc.pMidpoint(pt1,pt2)
    return { x = (pt1.x + pt2.x) / 2.0 , y = ( pt1.y + pt2.y) / 2.0 }
end

function cc.pForAngle(a)
    return { x = math.cos(a), y = math.sin(a) }
end

function cc.pGetLength(pt)
    return math.sqrt( pt.x * pt.x + pt.y * pt.y )
end

function cc.pNormalize(pt)
    local length = cc.pGetLength(pt)
    if 0 == length then
        return { x = 1.0,y = 0.0 }
    end

    return { x = pt.x / length, y = pt.y / length }
end

function cc.pCross(self,other)
    return self.x * other.y - self.y * other.x
end

function cc.pDot(self,other)
    return self.x * other.x + self.y * other.y
end

function cc.pToAngleSelf(self)
    return math.atan2(self.y, self.x)
end

function cc.pGetAngle(self,other)
    local a2 = cc.pNormalize(self)
    local b2 = cc.pNormalize(other)
    local angle = math.atan2(cc.pCross(a2, b2), cc.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end

    return angle
end

function cc.pGetDistance(startP,endP)
    return cc.pGetLength(cc.pSub(startP,endP))
end

function cc.pIsLineIntersect(A, B, C, D, s, t)
    if ((A.x == B.x) and (A.y == B.y)) or ((C.x == D.x) and (C.y == D.y))then
        return false, s, t
    end

    local BAx = B.x - A.x
    local BAy = B.y - A.y
    local DCx = D.x - C.x
    local DCy = D.y - C.y
    local ACx = A.x - C.x
    local ACy = A.y - C.y

    local denom = DCy * BAx - DCx * BAy
    s = DCx * ACy - DCy * ACx
    t = BAx * ACy - BAy * ACx

    if (denom == 0) then
        if (s == 0 or t == 0) then
            return true, s , t
        end

        return false, s, t
    end

    s = s / denom
    t = t / denom

    return true,s,t
end

function cc.pPerp(pt)
    return { x = -pt.y, y = pt.x }
end

function cc.RPerp(pt)
    return { x = pt.y,  y = -pt.x }
end

function cc.pProject(pt1, pt2)
    return { x = pt2.x * (cc.pDot(pt1,pt2) / cc.pDot(pt2,pt2)) , y = pt2.y * (cc.pDot(pt1,pt2) / cc.pDot(pt2,pt2)) }
end

function cc.pRotate(pt1, pt2)
    return { x = pt1.x * pt2.x - pt1.y * pt2.y, y = pt1.x * pt2.y + pt1.y * pt2.x }
end

function cc.pUnrotate(pt1, pt2)
    return { x = pt1.x * pt2.x + pt1.y * pt2.y, pt1.y * pt2.x - pt1.x * pt2.y }
end
--Calculates the square length of pt
function cc.pLengthSQ(pt)
    return cc.pDot(pt,pt)
end
--Calculates the square distance between pt1 and pt2
function cc.pDistanceSQ(pt1,pt2)
    return cc.pLengthSQ(cc.pSub(pt1,pt2))
end

function cc.pGetClampPoint(pt1,pt2,pt3)
    return { x = cc.clampf(pt1.x, pt2.x, pt3.x), y = cc.clampf(pt1.y, pt2.y, pt3.y) }
end

function cc.pFromSize(sz)
    return { x = sz.width, y = sz.height }
end

function cc.pLerp(pt1,pt2,alpha)
    return cc.pAdd(cc.pMul(pt1, 1.0 - alpha), cc.pMul(pt2,alpha) )
end

function cc.pFuzzyEqual(pt1,pt2,variance)
    if (pt1.x - variance <= pt2.x) and (pt2.x <= pt1.x + variance) and (pt1.y - variance <= pt2.y) and (pt2.y <= pt1.y + variance) then
        return true
    else
        return false
    end
end

function cc.pRotateByAngle(pt1, pt2, angle)
    return cc.pAdd(pt2, cc.pRotate( cc.pSub(pt1, pt2),cc.pForAngle(angle)))
end

function cc.pIsSegmentIntersect(pt1,pt2,pt3,pt4)
    local s,t,ret = 0,0,false
    ret,s,t =cc.pIsLineIntersect(pt1, pt2, pt3, pt4,s,t)

    if ret and  s >= 0.0 and s <= 1.0 and t >= 0.0 and t <= 0.0 then
        return true;
    end

    return false
end

function cc.pGetIntersectPoint(pt1,pt2,pt3,pt4)
    local s,t, ret = 0,0,false
    ret,s,t = cc.pIsLineIntersect(pt1,pt2,pt3,pt4,s,t)
    if ret then
        return cc.p(pt1.x + s * (pt2.x - pt1.x), pt1.y + s * (pt2.y - pt1.y))
    else
        return cc.p(0,0)
    end
end
--Size
function cc.size( _width,_height )
    return { width = _width, height = _height }
end

--Rect
function cc.rect(_x,_y,_width,_height)
    return { x = _x, y = _y, width = _width, height = _height }
end

function cc.rectEqualToRect(rect1,rect2)
    if ((rect1.x >= rect2.x) or (rect1.y >= rect2.y) or
        ( rect1.x + rect1.width <= rect2.x + rect2.width) or
        ( rect1.y + rect1.height <= rect2.y + rect2.height)) then
        return false
    end

    return true
end

function cc.rectGetMaxX(rect)
    return rect.x + rect.width
end

function cc.rectGetMidX(rect)
    return rect.x + rect.width / 2.0
end

function cc.rectGetMinX(rect)
    return rect.x
end

function cc.rectGetMaxY(rect)
    return rect.y + rect.height
end

function cc.rectGetMidY(rect)
    return rect.y + rect.height / 2.0
end

function cc.rectGetMinY(rect)
    return rect.y
end

function cc.rectContainsPoint( rect, point )
    local ret = false

    if (point.x >= rect.x) and (point.x <= rect.x + rect.width) and
       (point.y >= rect.y) and (point.y <= rect.y + rect.height) then
        ret = true
    end

    return ret
end

function cc.rectIntersectsRect( rect1, rect2 )
    local intersect = not ( rect1.x > rect2.x + rect2.width or
                    rect1.x + rect1.width < rect2.x         or
                    rect1.y > rect2.y + rect2.height        or
                    rect1.y + rect1.height < rect2.y )

    return intersect
end

function cc.rectUnion( rect1, rect2 )
    local rect = cc.rect(0, 0, 0, 0)
    rect.x = math.min(rect1.x, rect2.x)
    rect.y = math.min(rect1.y, rect2.y)
    rect.width = math.max(rect1.x + rect1.width, rect2.x + rect2.width) - rect.x
    rect.height = math.max(rect1.y + rect1.height, rect2.y + rect2.height) - rect.y
    return rect
end

function cc.rectIntersection( rect1, rect2 )
    local intersection = cc.rect(
        math.max(rect1.x, rect2.x),
        math.max(rect1.y, rect2.y),
        0, 0)

    intersection.width = math.min(rect1.x + rect1.width, rect2.x + rect2.width) - intersection.x
    intersection.height = math.min(rect1.y + rect1.height, rect2.y + rect2.height) - intersection.y
    return intersection
end

--Color3B
function cc.c3b( _r,_g,_b )
    return { r = _r, g = _g, b = _b }
end

--Color4B
function cc.c4b( _r,_g,_b,_a )
    return { r = _r, g = _g, b = _b, a = _a }
end

--Color4F
function cc.c4f( _r,_g,_b,_a )
    return { r = _r, g = _g, b = _b, a = _a }
end

--Vertex2F
function cc.vertex2F(_x,_y)
    return { x = _x, y = _y }
end

--Vertex3F
function cc.Vertex3F(_x,_y,_z)
    return { x = _x, y = _y, z = _z }
end

--Tex2F
function cc.tex2F(_u,_v)
    return { u = _u, v = _v }
end

--PointSprite
function cc.PointSprite(_pos,_color,_size)
    return { pos = _pos, color = _color, size = _size }
end

--Quad2
function cc.Quad2(_tl,_tr,_bl,_br)
    return { tl = _tl, tr = _tr, bl = _bl, br = _br }
end

--Quad3
function cc.Quad3(_tl, _tr, _bl, _br)
    return { tl = _tl, tr = _tr, bl = _bl, br = _br }
end

--V2F_C4B_T2F
function cc.V2F_C4B_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V2F_C4F_T2F
function cc.V2F_C4F_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V3F_C4B_T2F
function cc.V3F_C4B_T2F(_vertices, _colors, _texCoords)
    return { vertices = _vertices, colors = _colors, texCoords = _texCoords }
end

--V2F_C4B_T2F_Quad
function cc.V2F_C4B_T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--V3F_C4B_T2F_Quad
function cc.V3F_C4B_T2F_Quad(_tl, _bl, _tr, _br)
    return { tl = _tl, bl = _bl, tr = _tr, br = _br }
end

--V2F_C4F_T2F_Quad
function cc.V2F_C4F_T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--T2F_Quad
function cc.T2F_Quad(_bl, _br, _tl, _tr)
    return { bl = _bl, br = _br, tl = _tl, tr = _tr }
end

--AnimationFrameData
function cc.AnimationFrameData( _texCoords, _delay, _size)
    return { texCoords = _texCoords, delay = _delay, size = _size }
end

--PhysicsMaterial
function cc.PhysicsMaterial(_density, _restitution, _friction)
	return { density = _density, restitution = _restitution, friction = _friction }
end

cc.SPRITE_INDEX_NOT_INITIALIZED = 0xffffffff
cc.TMX_ORIENTATION_HEX  = 0x1
cc.TMX_ORIENTATION_ISO  = 0x2
cc.TMX_ORIENTATION_ORTHO    = 0x0
cc.Z_COMPRESSION_BZIP2  = 0x1
cc.Z_COMPRESSION_GZIP   = 0x2
cc.Z_COMPRESSION_NONE   = 0x3
cc.Z_COMPRESSION_ZLIB   = 0x0
cc.BLEND_DST    = 0x303
cc.BLEND_SRC    = 0x1
cc.DIRECTOR_IOS_USE_BACKGROUND_THREAD   = 0x0
cc.DIRECTOR_MAC_THREAD  = 0x0
cc.DIRECTOR_STATS_INTERVAL  = 0.1
cc.ENABLE_BOX2_D_INTEGRATION    = 0x0
cc.ENABLE_DEPRECATED    = 0x1
cc.ENABLE_GL_STATE_CACHE    = 0x1
cc.ENABLE_PROFILERS = 0x0
cc.ENABLE_STACKABLE_ACTIONS = 0x1
cc.FIX_ARTIFACTS_BY_STRECHING_TEXEL = 0x0
cc.GL_ALL   = 0x0
cc.LABELATLAS_DEBUG_DRAW    = 0x0
cc.LABELBMFONT_DEBUG_DRAW   = 0x0
cc.MAC_USE_DISPLAY_LINK_THREAD  = 0x0
cc.MAC_USE_MAIN_THREAD  = 0x2
cc.MAC_USE_OWN_THREAD   = 0x1
cc.NODE_RENDER_SUBPIXEL = 0x1
cc.PVRMIPMAP_MAX    = 0x10
cc.SPRITEBATCHNODE_RENDER_SUBPIXEL  = 0x1
cc.SPRITE_DEBUG_DRAW    = 0x0
cc.TEXTURE_ATLAS_USE_TRIANGLE_STRIP = 0x0
cc.TEXTURE_ATLAS_USE_VAO    = 0x1
cc.USE_L_A88_LABELS = 0x1
cc.ACTION_TAG_INVALID   = -1
cc.DEVICE_MAC   = 0x6
cc.DEVICE_MAC_RETINA_DISPLAY    = 0x7
cc.DEVICEI_PAD  = 0x4
cc.DEVICEI_PAD_RETINA_DISPLAY   = 0x5
cc.DEVICEI_PHONE    = 0x0
cc.DEVICEI_PHONE5   = 0x2
cc.DEVICEI_PHONE5_RETINA_DISPLAY    = 0x3
cc.DEVICEI_PHONE_RETINA_DISPLAY = 0x1
cc.DIRECTOR_PROJECTION2_D   = 0x0
cc.DIRECTOR_PROJECTION3_D   = 0x1
cc.DIRECTOR_PROJECTION_CUSTOM   = 0x2
cc.DIRECTOR_PROJECTION_DEFAULT  = 0x1
cc.FILE_UTILS_SEARCH_DIRECTORY_MODE = 0x1
cc.FILE_UTILS_SEARCH_SUFFIX_MODE    = 0x0
cc.FLIPED_ALL   = 0xe0000000
cc.FLIPPED_MASK = 0x1fffffff
cc.IMAGE_FORMAT_JPEG    = 0x0
cc.IMAGE_FORMAT_PNG = 0x1
cc.ITEM_SIZE    = 0x20
cc.LABEL_AUTOMATIC_WIDTH    = -1
cc.LINE_BREAK_MODE_CHARACTER_WRAP   = 0x1
cc.LINE_BREAK_MODE_CLIP = 0x2
cc.LINE_BREAK_MODE_HEAD_TRUNCATION  = 0x3
cc.LINE_BREAK_MODE_MIDDLE_TRUNCATION    = 0x5
cc.LINE_BREAK_MODE_TAIL_TRUNCATION  = 0x4
cc.LINE_BREAK_MODE_WORD_WRAP    = 0x0
cc.MAC_VERSION_10_6 = 0xa060000
cc.MAC_VERSION_10_7 = 0xa070000
cc.MAC_VERSION_10_8 = 0xa080000
cc.MENU_HANDLER_PRIORITY    = -128
cc.MENU_STATE_TRACKING_TOUCH    = 0x1
cc.MENU_STATE_WAITING   = 0x0
cc.NODE_TAG_INVALID = -1
cc.PARTICLE_DURATION_INFINITY   = -1
cc.PARTICLE_MODE_GRAVITY    = 0x0
cc.PARTICLE_MODE_RADIUS = 0x1
cc.PARTICLE_START_RADIUS_EQUAL_TO_END_RADIUS    = -1
cc.PARTICLE_START_SIZE_EQUAL_TO_END_SIZE    = -1
cc.POSITION_TYPE_FREE   = 0x0
cc.POSITION_TYPE_GROUPED    = 0x2
cc.POSITION_TYPE_RELATIVE   = 0x1
cc.PRIORITY_NON_SYSTEM_MIN  = -2147483647
cc.PRIORITY_SYSTEM  = -2147483648
cc.PROGRESS_TIMER_TYPE_BAR  = 0x1
cc.PROGRESS_TIMER_TYPE_RADIAL   = 0x0
cc.REPEAT_FOREVER   = 0xfffffffe
cc.RESOLUTION_MAC   = 0x1
cc.RESOLUTION_MAC_RETINA_DISPLAY    = 0x2
cc.RESOLUTION_UNKNOWN   = 0x0
cc.TMX_TILE_DIAGONAL_FLAG   = 0x20000000
cc.TMX_TILE_HORIZONTAL_FLAG = 0x80000000
cc.TMX_TILE_VERTICAL_FLAG   = 0x40000000
cc.TEXT_ALIGNMENT_CENTER    = 0x1
cc.TEXT_ALIGNMENT_LEFT  = 0x0
cc.TEXT_ALIGNMENT_RIGHT = 0x2

cc.TEXTURE2_D_PIXEL_FORMAT_AUTO = 0x0
cc.TEXTURE2_D_PIXEL_FORMAT_BGR_A8888 = 0x1
cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888 = 0x2
cc.TEXTURE2_D_PIXEL_FORMAT_RG_B888    = 0x3
cc.TEXTURE2_D_PIXEL_FORMAT_RG_B565   = 0x4
cc.TEXTURE2_D_PIXEL_FORMAT_A8        = 0x5
cc.TEXTURE2_D_PIXEL_FORMAT_I8        = 0x6
cc.TEXTURE2_D_PIXEL_FORMAT_A_I88     = 0x7
cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A4444     = 0x8
cc.TEXTURE2_D_PIXEL_FORMAT_RGB5_A1       = 0x9
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC4        = 0xa
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC4A       = 0xb
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC2        = 0xc
cc.TEXTURE2_D_PIXEL_FORMAT_PVRTC2A       = 0xd
cc.TEXTURE2_D_PIXEL_FORMAT_ETC           = 0xe
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT1     = 0xf
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT3     = 0x10
cc.TEXTURE2_D_PIXEL_FORMAT_S3TC_DXT5     = 0x11
cc.TEXTURE2_D_PIXEL_FORMAT_DEFAULT       = 0x0
cc.TOUCHES_ALL_AT_ONCE  = 0x0
cc.TOUCHES_ONE_BY_ONE   = 0x1
cc.TRANSITION_ORIENTATION_DOWN_OVER = 0x1
cc.TRANSITION_ORIENTATION_LEFT_OVER = 0x0
cc.TRANSITION_ORIENTATION_RIGHT_OVER    = 0x1
cc.TRANSITION_ORIENTATION_UP_OVER   = 0x0
cc.UNIFORM_COS_TIME = 0x5
cc.UNIFORM_MV_MATRIX    = 0x1
cc.UNIFORM_MVP_MATRIX   = 0x2
cc.UNIFORM_P_MATRIX = 0x0
cc.UNIFORM_RANDOM01 = 0x6
cc.UNIFORM_SAMPLER  = 0x7
cc.UNIFORM_SIN_TIME = 0x4
cc.UNIFORM_TIME = 0x3
cc.UNIFORM_MAX  = 0x8
cc.VERTEX_ATTRIB_FLAG_COLOR = 0x2
cc.VERTEX_ATTRIB_FLAG_NONE  = 0x0
cc.VERTEX_ATTRIB_FLAG_POS_COLOR_TEX = 0x7
cc.VERTEX_ATTRIB_FLAG_POSITION  = 0x1
cc.VERTEX_ATTRIB_FLAG_TEX_COORDS    = 0x4
cc.VERTEX_ATTRIB_COLOR  = 0x1
cc.VERTEX_ATTRIB_MAX    = 0x3
cc.VERTEX_ATTRIB_POSITION   = 0x0
cc.VERTEX_ATTRIB_TEX_COORD = 0x2

cc.VERTEX_ATTRIB_TEX_COORDS = 0x2
cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM   = 0x2
cc.VERTICAL_TEXT_ALIGNMENT_CENTER   = 0x1
cc.VERTICAL_TEXT_ALIGNMENT_TOP  = 0x0
cc.OS_VERSION_4_0   = 0x4000000
cc.OS_VERSION_4_0_1 = 0x4000100
cc.OS_VERSION_4_1   = 0x4010000
cc.OS_VERSION_4_2   = 0x4020000
cc.OS_VERSION_4_2_1 = 0x4020100
cc.OS_VERSION_4_3   = 0x4030000
cc.OS_VERSION_4_3_1 = 0x4030100
cc.OS_VERSION_4_3_2 = 0x4030200
cc.OS_VERSION_4_3_3 = 0x4030300
cc.OS_VERSION_4_3_4 = 0x4030400
cc.OS_VERSION_4_3_5 = 0x4030500
cc.OS_VERSION_5_0   = 0x5000000
cc.OS_VERSION_5_0_1 = 0x5000100
cc.OS_VERSION_5_1_0 = 0x5010000
cc.OS_VERSION_6_0_0 = 0x6000000
cc.ANIMATION_FRAME_DISPLAYED_NOTIFICATION   = 'CCAnimationFrameDisplayedNotification'
cc.CHIPMUNK_IMPORT  = 'chipmunk.h'
cc.ATTRIBUTE_NAME_COLOR = 'a_color'
cc.ATTRIBUTE_NAME_POSITION  = 'a_position'
cc.ATTRIBUTE_NAME_TEX_COORD = 'a_texCoord'
cc.SHADER_POSITION_COLOR    = 'ShaderPositionColor'
cc.SHADER_POSITION_LENGTH_TEXURE_COLOR  = 'ShaderPositionLengthTextureColor'
cc.SHADER_POSITION_TEXTURE  = 'ShaderPositionTexture'
cc.SHADER_POSITION_TEXTURE_A8_COLOR = 'ShaderPositionTextureA8Color'
cc.SHADER_POSITION_TEXTURE_COLOR    = 'ShaderPositionTextureColor'
cc.SHADER_POSITION_TEXTURE_COLOR_ALPHA_TEST = 'ShaderPositionTextureColorAlphaTest'
cc.SHADER_POSITION_TEXTURE_U_COLOR  = 'ShaderPositionTexture_uColor'
cc.SHADER_POSITION_U_COLOR  = 'ShaderPosition_uColor'
cc.UNIFORM_ALPHA_TEST_VALUE_S   = 'CC_AlphaValue'
cc.UNIFORM_COS_TIME_S   = 'CC_CosTime'
cc.UNIFORM_MV_MATRIX_S  = 'CC_MVMatrix'
cc.UNIFORM_MVP_MATRIX_S = 'CC_MVPMatrix'
cc.UNIFORM_P_MATRIX_S   = 'CC_PMatrix'
cc.UNIFORM_RANDOM01_S   = 'CC_Random01'
cc.UNIFORM_SAMPLER_S    = 'CC_Texture0'
cc.UNIFORM_SIN_TIME_S   = 'CC_SinTime'
cc.UNIFORM_TIME_S   = 'CC_Time'

cc.PLATFORM_OS_WINDOWS = 0
cc.PLATFORM_OS_LINUX   = 1
cc.PLATFORM_OS_MAC     = 2
cc.PLATFORM_OS_ANDROID = 3
cc.PLATFORM_OS_IPHONE  = 4
cc.PLATFORM_OS_IPAD    = 5
cc.PLATFORM_OS_BLACKBERRY = 6
cc.PLATFORM_OS_NACL    = 7
cc.PLATFORM_OS_EMSCRIPTEN = 8
cc.PLATFORM_OS_TIZEN   = 9

cc.SCROLLVIEW_SCRIPT_SCROLL = 0
cc.SCROLLVIEW_SCRIPT_ZOOM   = 1
cc.TABLECELL_TOUCHED        = 2
cc.TABLECELL_HIGH_LIGHT     = 3
cc.TABLECELL_UNHIGH_LIGHT   = 4
cc.TABLECELL_WILL_RECYCLE   = 5
cc.TABLECELL_SIZE_FOR_INDEX = 6
cc.TABLECELL_SIZE_AT_INDEX  = 7
cc.NUMBER_OF_CELLS_IN_TABLEVIEW = 8

cc.SCROLLVIEW_DIRECTION_NONE = -1
cc.SCROLLVIEW_DIRECTION_HORIZONTAL = 0
cc.SCROLLVIEW_DIRECTION_VERTICAL = 1
cc.SCROLLVIEW_DIRECTION_BOTH  = 2

cc.CONTROL_EVENTTYPE_TOUCH_DOWN = 1
cc.CONTROL_EVENTTYPE_DRAG_INSIDE = 2
cc.CONTROL_EVENTTYPE_DRAG_OUTSIDE = 4
cc.CONTROL_EVENTTYPE_DRAG_ENTER = 8
cc.CONTROL_EVENTTYPE_DRAG_EXIT = 16
cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE = 32
cc.CONTROL_EVENTTYPE_TOUCH_UP_OUTSIDE = 64
cc.CONTROL_EVENTTYPE_TOUCH_CANCEL    = 128
cc.CONTROL_EVENTTYPE_VALUE_CHANGED   = 256

cc.CONTROL_STATE_NORMAL  = 1
cc.CONTROL_STATE_HIGH_LIGHTED = 2
cc.CONTROL_STATE_DISABLED = 4
cc.CONTROL_STATE_SELECTED = 8


cc.KEYBOARD_RETURNTYPE_DEFAULT = 0
cc.KEYBOARD_RETURNTYPE_DONE = 1
cc.KEYBOARD_RETURNTYPE_SEND = 2
cc.KEYBOARD_RETURNTYPE_SEARCH = 3
cc.KEYBOARD_RETURNTYPE_GO = 4


cc.EDITBOX_INPUT_MODE_ANY = 0
cc.EDITBOX_INPUT_MODE_EMAILADDR = 1
cc.EDITBOX_INPUT_MODE_NUMERIC = 2
cc.EDITBOX_INPUT_MODE_PHONENUMBER = 3
cc.EDITBOX_INPUT_MODE_URL = 4
cc.EDITBOX_INPUT_MODE_DECIMAL = 5
cc.EDITBOX_INPUT_MODE_SINGLELINE = 6


cc.EDITBOX_INPUT_FLAG_PASSWORD = 0
cc.EDITBOX_INPUT_FLAG_SENSITIVE = 1
cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD = 2
cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE = 3
cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_ALL_CHARACTERS = 4

cc.LANGUAGE_ENGLISH    = 0
cc.LANGUAGE_CHINESE    = 1
cc.LANGUAGE_FRENCH     = 2
cc.LANGUAGE_ITALIAN    = 3
cc.LANGUAGE_GERMAN     = 4
cc.LANGUAGE_SPANISH    = 5
cc.LANGUAGE_RUSSIAN    = 6
cc.LANGUAGE_KOREAN     = 7
cc.LANGUAGE_JAPANESE   = 8
cc.LANGUAGE_HUNGARIAN  = 9
cc.LANGUAGE_PORTUGUESE = 10
cc.LANGUAGE_ARABIC     = 11

cc.NODE_ON_ENTER       = 0
cc.NODE_ON_EXIT        = 1
cc.NODE_ON_ENTER_TRANSITION_DID_FINISH = 2
cc.NODE_ON_EXIT_TRANSITION_DID_START   = 3
cc.NODE_ON_CLEAN_UP    = 4

cc.CONTROL_STEPPER_PART_MINUS = 0
cc.CONTROL_STEPPER_PART_PLUS  = 1
cc.CONTROL_STEPPER_PART_NONE  = 2

cc.TABLEVIEW_FILL_TOPDOWN = 0
cc.TABLEVIEW_FILL_BOTTOMUP = 1

cc.WEBSOCKET_OPEN     = 0
cc.WEBSOCKET_MESSAGE  = 1
cc.WEBSOCKET_CLOSE    = 2
cc.WEBSOCKET_ERROR    = 3

cc.WEBSOCKET_STATE_CONNECTING = 0
cc.WEBSOCKET_STATE_OPEN       = 1
cc.WEBSOCKET_STATE_CLOSING    = 2
cc.WEBSOCKET_STATE_CLOSED     = 3


cc.XMLHTTPREQUEST_RESPONSE_STRING = 0
cc.XMLHTTPREQUEST_RESPONSE_ARRAY_BUFFER = 1
cc.XMLHTTPREQUEST_RESPONSE_BLOB   = 2
cc.XMLHTTPREQUEST_RESPONSE_DOCUMENT = 3
cc.XMLHTTPREQUEST_RESPONSE_JSON = 4

cc.ASSETSMANAGER_CREATE_FILE  = 0
cc.ASSETSMANAGER_NETWORK = 1
cc.ASSETSMANAGER_NO_NEW_VERSION = 2
cc.ASSETSMANAGER_UNCOMPRESS     = 3

cc.ASSETSMANAGER_PROTOCOL_PROGRESS =  0
cc.ASSETSMANAGER_PROTOCOL_SUCCESS  =  1
cc.ASSETSMANAGER_PROTOCOL_ERROR    =  2

cc.Handler = cc.Handler or {}
cc.Handler.NODE            = 0
cc.Handler.MENU_CLICKED    = 1
cc.Handler.CALLFUNC        = 2
cc.Handler.SCHEDULE        = 3
cc.Handler.TOUCHES         = 4
cc.Handler.KEYPAD          = 5
cc.Handler.ACCELEROMETER   = 6
cc.Handler.CONTROL_TOUCH_DOWN = 7
cc.Handler.CONTROL_TOUCH_DRAG_INSIDE = 8
cc.Handler.CONTROL_TOUCH_DRAG_OUTSIDE = 9
cc.Handler.CONTROL_TOUCH_DRAG_ENTER = 10
cc.Handler.CONTROL_TOUCH_DRAG_EXIT  = 11
cc.Handler.CONTROL_TOUCH_UP_INSIDE  = 12
cc.Handler.CONTROL_TOUCH_UP_OUTSIDE = 13
cc.Handler.CONTROL_TOUCH_UP_CANCEL  = 14
cc.Handler.CONTROL_VALUE_CHANGED    = 15
cc.Handler.WEBSOCKET_OPEN           = 16
cc.Handler.WEBSOCKET_MESSAGE        = 17
cc.Handler.WEBSOCKET_CLOSE          = 18
cc.Handler.WEBSOCKET_ERROR          = 19
cc.Handler.GL_NODE_DRAW             = 20
cc.Handler.SCROLLVIEW_SCROLL        = 21
cc.Handler.SCROLLVIEW_ZOOM          = 22
cc.Handler.TABLECELL_TOUCHED        = 23
cc.Handler.TABLECELL_HIGHLIGHT      = 24
cc.Handler.TABLECELL_UNHIGHLIGHT    = 25
cc.Handler.TABLECELL_WILL_RECYCLE   = 26
cc.Handler.TABLECELL_SIZE_FOR_INDEX = 27
cc.Handler.TABLECELL_AT_INDEX       = 28
cc.Handler.TABLEVIEW_NUMS_OF_CELLS  = 29
cc.Handler.HTTPREQUEST_STATE_CHANGE = 30
cc.Handler.ASSETSMANAGER_PROGRESS = 31
cc.Handler.ASSETSMANAGER_SUCCESS  = 32
cc.Handler.ASSETSMANAGER_ERROR    = 33
cc.Handler.STUDIO_EVENT_LISTENER  = 34
cc.Handler.ARMATURE_EVENT         = 35
cc.Handler.EVENT_ACC              = 36
cc.Handler.EVENT_CUSTIOM          = 37
cc.Handler.EVENT_KEYBOARD_PRESSED = 38
cc.Handler.EVENT_KEYBOARD_RELEASED = 39
cc.Handler.EVENT_TOUCH_BEGAN      = 40
cc.Handler.EVENT_TOUCH_MOVED      = 41
cc.Handler.EVENT_TOUCH_ENDED      = 42
cc.Handler.EVENT_TOUCH_CANCELLED  = 43
cc.Handler.EVENT_TOUCHES_BEGAN    = 44
cc.Handler.EVENT_TOUCHES_MOVED    = 45
cc.Handler.EVENT_TOUCHES_ENDED    = 46
cc.Handler.EVENT_TOUCHES_CANCELLED = 47
cc.Handler.EVENT_MOUSE_DOWN       = 48
cc.Handler.EVENT_MOUSE_UP         = 49
cc.Handler.EVENT_MOUSE_MOVE       = 50
cc.Handler.EVENT_MOUSE_SCROLL     = 51
cc.Handler.EVENT_SPINE            = 52
cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN = 53
cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE = 54
cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE = 55
cc.Handler.EVENT_PHYSICS_CONTACT_SEPERATE = 56

cc.EVENT_UNKNOWN = 0
cc.EVENT_TOUCH_ONE_BY_ONE      = 1
cc.EVENT_TOUCH_ALL_AT_ONCE     = 2
cc.EVENT_KEYBOARD              = 3
cc.EVENT_MOUSE                 = 4
cc.EVENT_ACCELERATION          = 5
cc.EVENT_CUSTOM                = 6

cc.PHYSICSSHAPE_MATERIAL_DEFAULT = {density = 0.0, restitution = 0.5, friction = 0.5}
cc.PHYSICSBODY_MATERIAL_DEFAULT = {density = 0.1, restitution = 0.5, friction = 0.5}
cc.GLYPHCOLLECTION_DYNAMIC = 0
cc.GLYPHCOLLECTION_NEHE    = 1
cc.GLYPHCOLLECTION_ASCII   = 2
cc.GLYPHCOLLECTION_CUSTOM  = 3


cc.ResolutionPolicy = {}
cc.ResolutionPolicy.EXACT_FIT = 0
cc.ResolutionPolicy.NO_BORDER = 1
cc.ResolutionPolicy.SHOW_ALL  = 2
cc.ResolutionPolicy.FIXED_HEIGHT  = 3
cc.ResolutionPolicy.FIXED_WIDTH  = 4
cc.ResolutionPolicy.UNKNOWN  = 5

cc.LabelEffect = {}
cc.LabelEffect.NORMAL  = 0
cc.LabelEffect.OUTLINE = 1
cc.LabelEffect.SHADOW  = 2
cc.LabelEffect.GLOW    = 3

cc.KeyCode = {}
cc.KeyCode.KEY_NONE              = 0
cc.KeyCode.KEY_PAUSE             = 0x0013
cc.KeyCode.KEY_SCROLL_LOCK       = 0x1014
cc.KeyCode.KEY_PRINT             = 0x1061
cc.KeyCode.KEY_SYSREQ            = 0x106A
cc.KeyCode.KEY_BREAK             = 0x106B
cc.KeyCode.KEY_ESCAPE            = 0x001B
cc.KeyCode.KEY_BACKSPACE         = 0x0008
cc.KeyCode.KEY_TAB               = 0x0009
cc.KeyCode.KEY_BACK_TAB          = 0x0089
cc.KeyCode.KEY_RETURN            = 0x000D
cc.KeyCode.KEY_CAPS_LOCK         = 0x00E5
cc.KeyCode.KEY_SHIFT             = 0x00E1
cc.KeyCode.KEY_CTRL              = 0x00E3
cc.KeyCode.KEY_ALT               = 0x00E9
cc.KeyCode.KEY_MENU              = 0x1067
cc.KeyCode.KEY_HYPER             = 0x10ED
cc.KeyCode.KEY_INSERT            = 0x1063
cc.KeyCode.KEY_HOME              = 0x1050
cc.KeyCode.KEY_PG_UP             = 0x1055
cc.KeyCode.KEY_DELETE            = 0x10FF
cc.KeyCode.KEY_END               = 0x1057
cc.KeyCode.KEY_PG_DOWN           = 0x1056
cc.KeyCode.KEY_LEFT_ARROW        = 0x1051
cc.KeyCode.KEY_RIGHT_ARROW       = 0x1053
cc.KeyCode.KEY_UP_ARROW          = 0x1052
cc.KeyCode.KEY_DOWN_ARROW        = 0x1054
cc.KeyCode.KEY_NUM_LOCK          = 0x107F
cc.KeyCode.KEY_KP_PLUS           = 0x10AB
cc.KeyCode.KEY_KP_MINUS          = 0x10AD
cc.KeyCode.KEY_KP_MULTIPLY       = 0x10AA
cc.KeyCode.KEY_KP_DIVIDE         = 0x10AF
cc.KeyCode.KEY_KP_ENTER          = 0x108D
cc.KeyCode.KEY_KP_HOME           = 0x10B7
cc.KeyCode.KEY_KP_UP             = 0x10B8
cc.KeyCode.KEY_KP_PG_UP          = 0x10B9
cc.KeyCode.KEY_KP_LEFT           = 0x10B4
cc.KeyCode.KEY_KP_FIVE           = 0x10B5
cc.KeyCode.KEY_KP_RIGHT          = 0x10B6
cc.KeyCode.KEY_KP_END            = 0x10B1
cc.KeyCode.KEY_KP_DOWN           = 0x10B2
cc.KeyCode.KEY_KP_PG_DOWN        = 0x10B3
cc.KeyCode.KEY_KP_INSERT         = 0x10B0
cc.KeyCode.KEY_KP_DELETE         = 0x10AE
cc.KeyCode.KEY_F1                = 0x00BE
cc.KeyCode.KEY_F2                = 0x00BF
cc.KeyCode.KEY_F3                = 0x00C0
cc.KeyCode.KEY_F4                = 0x00C1
cc.KeyCode.KEY_F5                = 0x00C2
cc.KeyCode.KEY_F6                = 0x00C3
cc.KeyCode.KEY_F7                = 0x00C4
cc.KeyCode.KEY_F8                = 0x00C5
cc.KeyCode.KEY_F9                = 0x00C6
cc.KeyCode.KEY_F10               = 0x00C7
cc.KeyCode.KEY_F11               = 0x00C8
cc.KeyCode.KEY_F12               = 0x00C9
cc.KeyCode.KEY_SPACE             = ' '
cc.KeyCode.KEY_EXCLAM            = '!'
cc.KeyCode.KEY_QUOTE             = '"'
cc.KeyCode.KEY_NUMBER            = '#'
cc.KeyCode.KEY_DOLLAR            = '$'
cc.KeyCode.KEY_PERCENT           = '%'
cc.KeyCode.KEY_CIRCUMFLEX        = '^'
cc.KeyCode.KEY_AMPERSAND         = '&'
cc.KeyCode.KEY_APOSTROPHE        = '\''
cc.KeyCode.KEY_LEFT_PARENTHESIS  = '('
cc.KeyCode.KEY_RIGHT_PARENTHESIS = ')'
cc.KeyCode.KEY_ASTERISK          = '*'
cc.KeyCode.KEY_PLUS              = '+'
cc.KeyCode.KEY_COMMA             = ''
cc.KeyCode.KEY_MINUS             = '-'
cc.KeyCode.KEY_PERIOD            = '.'
cc.KeyCode.KEY_SLASH             = '/'
cc.KeyCode.KEY_0                 = '0'
cc.KeyCode.KEY_1                 = '1'
cc.KeyCode.KEY_2                 = '2'
cc.KeyCode.KEY_3                 = '3'
cc.KeyCode.KEY_4                 = '4'
cc.KeyCode.KEY_5                 = '5'
cc.KeyCode.KEY_6                 = '6'
cc.KeyCode.KEY_7                 = '7'
cc.KeyCode.KEY_8                 = '8'
cc.KeyCode.KEY_9                 = '9'
cc.KeyCode.KEY_COLON             = ':'
cc.KeyCode.KEY_SEMICOLON         = ';'
cc.KeyCode.KEY_LESS_THAN         = '<'
cc.KeyCode.KEY_EQUAL             = '='
cc.KeyCode.KEY_GREATER_THAN      = '>'
cc.KeyCode.KEY_QUESTION          = '?'
cc.KeyCode.KEY_AT                = '@'
cc.KeyCode.KEY_CAPITAL_A         = 'A'
cc.KeyCode.KEY_CAPITAL_B         = 'B'
cc.KeyCode.KEY_CAPITAL_C         = 'C'
cc.KeyCode.KEY_CAPITAL_D         = 'D'
cc.KeyCode.KEY_CAPITAL_E         = 'E'
cc.KeyCode.KEY_CAPITAL_F         = 'F'
cc.KeyCode.KEY_CAPITAL_G         = 'G'
cc.KeyCode.KEY_CAPITAL_H         = 'H'
cc.KeyCode.KEY_CAPITAL_I         = 'I'
cc.KeyCode.KEY_CAPITAL_J         = 'J'
cc.KeyCode.KEY_CAPITAL_K         = 'K'
cc.KeyCode.KEY_CAPITAL_L         = 'L'
cc.KeyCode.KEY_CAPITAL_M         = 'M'
cc.KeyCode.KEY_CAPITAL_N         = 'N'
cc.KeyCode.KEY_CAPITAL_O         = 'O'
cc.KeyCode.KEY_CAPITAL_P         = 'P'
cc.KeyCode.KEY_CAPITAL_Q         = 'Q'
cc.KeyCode.KEY_CAPITAL_R         = 'R'
cc.KeyCode.KEY_CAPITAL_S         = 'S'
cc.KeyCode.KEY_CAPITAL_T         = 'T'
cc.KeyCode.KEY_CAPITAL_U         = 'U'
cc.KeyCode.KEY_CAPITAL_V         = 'V'
cc.KeyCode.KEY_CAPITAL_W         = 'W'
cc.KeyCode.KEY_CAPITAL_X         = 'X'
cc.KeyCode.KEY_CAPITAL_Y         = 'Y'
cc.KeyCode.KEY_CAPITAL_Z         = 'Z'
cc.KeyCode.KEY_LEFT_BRACKET      = '['
cc.KeyCode.KEY_BACK_SLASH        = '\\'
cc.KeyCode.KEY_RIGHT_BRACKET     = ']'
cc.KeyCode.KEY_UNDERSCORE        = '_'
cc.KeyCode.KEY_GRAVE             = '`'
cc.KeyCode.KEY_A                 = 'a'
cc.KeyCode.KEY_B                 = 'b'
cc.KeyCode.KEY_C                 = 'c'
cc.KeyCode.KEY_D                 = 'd'
cc.KeyCode.KEY_E                 = 'e'
cc.KeyCode.KEY_F                 = 'f'
cc.KeyCode.KEY_G                 = 'g'
cc.KeyCode.KEY_H                 = 'h'
cc.KeyCode.KEY_I                 = 'i'
cc.KeyCode.KEY_J                 = 'j'
cc.KeyCode.KEY_K                 = 'k'
cc.KeyCode.KEY_L                 = 'l'
cc.KeyCode.KEY_M                 = 'm'
cc.KeyCode.KEY_N                 = 'n'
cc.KeyCode.KEY_O                 = 'o'
cc.KeyCode.KEY_P                 = 'p'
cc.KeyCode.KEY_Q                 = 'q'
cc.KeyCode.KEY_R                 = 'r'
cc.KeyCode.KEY_S                 = 's'
cc.KeyCode.KEY_T                 = 't'
cc.KeyCode.KEY_U                 = 'u'
cc.KeyCode.KEY_V                 = 'v'
cc.KeyCode.KEY_W                 = 'w'
cc.KeyCode.KEY_X                 = 'x'
cc.KeyCode.KEY_Y                 = 'y'
cc.KeyCode.KEY_Z                 = 'z'
cc.KeyCode.KEY_LEFT_BRACE        = '{'
cc.KeyCode.KEY_BAR               = '|'
cc.KeyCode.KEY_RIGHT_BRACE       = '}'
cc.KeyCode.KEY_TILDE             = '~'
cc.KeyCode.KEY_EURO              = 0x20AC
cc.KeyCode.KEY_POUND             = 0x00A3
cc.KeyCode.KEY_YEN               = 0x00A5
cc.KeyCode.KEY_MIDDLE_DOT        = 0x0095
cc.KeyCode.KEY_SEARCH            = 0xFFAA







return cc
