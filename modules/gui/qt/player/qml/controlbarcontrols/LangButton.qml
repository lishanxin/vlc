/*****************************************************************************
 * Copyright (C) 2021 VLC authors and VideoLAN
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * ( at your option ) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/
import QtQuick 2.11

import org.videolan.vlc 0.1

import "qrc:///widgets/" as Widgets
import "qrc:///style/"
import "qrc:///player/" as Player


Widgets.IconControlButton {
    id: langBtn
    size: VLCStyle.icon_medium
    iconText: VLCIcons.audiosub

    enabled: langMenuLoader.status === Loader.Ready
    onClicked: langMenuLoader.item.open()

    text: I18n.qtr("Languages and tracks")

    Loader {
        id: langMenuLoader

        active: (typeof rootPlayer !== 'undefined') && (rootPlayer !== null)

        sourceComponent: Player.LanguageMenu {
            id: langMenu

            parent: rootPlayer
            focus: true
            x: 0
            y: (rootPlayer.positionSliderY - height)
            z: 1

            onOpened: {
                playerControlLayout.requestLockUnlockAutoHide(true, playerControlLayout)
                if (!!rootPlayer)
                    rootPlayer.menu = langMenu
            }

            onClosed: {
                playerControlLayout.requestLockUnlockAutoHide(false, playerControlLayout)
                langBtn.forceActiveFocus()
                if (!!rootPlayer)
                    rootPlayer.menu = undefined
            }
        }
    }
}
