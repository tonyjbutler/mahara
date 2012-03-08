<?php
/**
 * Mahara: Electronic portfolio, weblog, resume builder and social networking
 * Copyright (C) 2006-2008 Catalyst IT Ltd (http://www.catalyst.net.nz)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @package    mahara
 * @subpackage blocktype-developmentlogentry
 * @author     Catalyst IT Ltd
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL
 * @copyright  (C) 2006-2008 Catalyst IT Ltd http://catalyst.net.nz
 *
 */

defined('INTERNAL') || die();

class PluginBlocktypeDevelopmentlogentry extends SystemBlocktype {

    public static function get_title() {
        return get_string('title', 'blocktype.developmentlogentry');
    }

    public static function get_description() {
        return get_string('description', 'blocktype.developmentlogentry');
    }

    public static function get_categories() {
        return array('general');
    }

    public static function get_viewtypes() {
        return array('portfolio', 'profile');
    }

    public static function render_instance(BlockInstance $instance, $editing=false) {
        $configdata = $instance->get('configdata');
        $text  = '<table style="border-collapse: separate; border-spacing: 12px;">';
        $text .= '<tr>';
        $text .= '<th style="border-bottom: 1px solid #D2D2D2;" scope="col">' . get_string('whydevelop', 'blocktype.developmentlogentry') . '</th>';
        $text .= '<th style="border-bottom: 1px solid #D2D2D2;" scope="col">' . get_string('whatlearnt', 'blocktype.developmentlogentry') . '</th>';
        $text .= '<th style="border-bottom: 1px solid #D2D2D2;" scope="col">' . get_string('whatachieved', 'blocktype.developmentlogentry') . '</th>';
        $text .= '<th style="border-bottom: 1px solid #D2D2D2;" scope="col">' . get_string('date', 'blocktype.developmentlogentry') . '</th>';
        $text .= '<th style="border-bottom: 1px solid #D2D2D2;" scope="col">' . get_string('evidence', 'blocktype.developmentlogentry') . '</th>';
        $text .= '</tr>';
        $text .= '<tr>';
        $text .= '<td>';
        $text .= (isset($configdata['develop'])) ? $configdata['develop'] : '';
        $text .= '</td>';
        $text .= '<td>';
        $text .= (isset($configdata['learnt'])) ? $configdata['learnt'] : '';
        $text .= '</td>';
        $text .= '<td>';
        $text .= (isset($configdata['achieved'])) ? $configdata['achieved'] : '';
        $text .= '</td>';
        $text .= '<td>';
        $text .= (isset($configdata['date'])) ? $configdata['date'] : '';
        $text .= '<td>';
        $text .= (isset($configdata['evidence'])) ? $configdata['evidence'] : '';
        $text .= '</td>';
        $text .= '</tr>';
        $text .= '</table>';
        safe_require('artefact', 'file');
        $text = ArtefactTypeFolder::append_view_url($text,$instance->get('view'));
        return clean_html($text);
    }

    /**
     * Returns a list of artefact IDs that are in this blockinstance.
     *
     * People may embed artefacts as images etc. They show up as links to the 
     * download script, which isn't much to go on, but should be enough for us 
     * to detect that the artefacts are therefore 'in' this blocktype.
     */
    public static function get_artefacts(BlockInstance $instance) {
        $artefacts = array();
        $configdata = $instance->get('configdata');
        if (isset($configdata['develop'])) {
            require_once(get_config('docroot') . 'artefact/lib.php');
            $artefacts = artefact_get_references_in_html($configdata['develop']);
        }
        if (isset($configdata['learnt'])) {
            require_once(get_config('docroot') . 'artefact/lib.php');
            $artefacts = artefact_get_references_in_html($configdata['learnt']);
        }
        if (isset($configdata['achieved'])) {
            require_once(get_config('docroot') . 'artefact/lib.php');
            $artefacts = artefact_get_references_in_html($configdata['achieved']);
        }
        if (isset($configdata['date'])) {
            require_once(get_config('docroot') . 'artefact/lib.php');
            $artefacts = artefact_get_references_in_html($configdata['date']);
        }
        if (isset($configdata['evidence'])) {
            require_once(get_config('docroot') . 'artefact/lib.php');
            $artefacts = artefact_get_references_in_html($configdata['evidence']);
        }
        return $artefacts;
    }

    public static function has_instance_config() {
        return true;
    }

    public static function instance_config_form($instance) {
        $configdata = $instance->get('configdata');
        return array(
            'develop' => array(
                'type' => 'tinywysiwyg',
                'title' => get_string('whydevelop', 'blocktype.developmentlogentry'),
                'width' => '90%',
                'height' => '150px',
                'defaultvalue' => $configdata['develop'],
            ),
            'learnt' => array(
                'type' => 'tinywysiwyg',
                'title' => get_string('whatlearnt', 'blocktype.developmentlogentry'),
                'width' => '90%',
                'height' => '150px',
                'defaultvalue' => $configdata['learnt'],
            ),
            'achieved' => array(
                'type' => 'tinywysiwyg',
                'title' => get_string('whatachieved', 'blocktype.developmentlogentry'),
                'width' => '90%',
                'height' => '150px',
                'defaultvalue' => $configdata['achieved'],
            ),
            'date' => array(
                'type' => 'text',
                'title' => get_string('dateachieved', 'blocktype.developmentlogentry'),
                'defaultvalue' => $configdata['date'],
            ),
            'evidence' => array(
                'type' => 'tinywysiwyg',
                'title' => get_string('evidence', 'blocktype.developmentlogentry'),
                'width' => '90%',
                'height' => '150px',
                'defaultvalue' => $configdata['evidence'],
            ),
        );
    }

    public static function default_copy_type() {
        return 'full';
    }

}

?>
