<?php
/**
 * REST API Routes Definition for HMJTI Member Management
 * According to PRD Section 14.4 (Folder Structure Backend) & Section 16/17 (API Specification)
 */

class ApiRouter {
    public static function handleRequest($path, $method) {
        if ($path === '/api/login' || $path === '/login') {
            if ($method === 'POST') {
                (new AuthController())->login();
                return true;
            }
        } elseif ($path === '/api/logout' || $path === '/logout') {
            if ($method === 'POST') {
                (new AuthController())->logout();
                return true;
            }
        } elseif ($path === '/api/dashboard' || $path === '/dashboard') {
            if ($method === 'GET') {
                (new DashboardController())->getStats();
                return true;
            }
        } elseif (preg_match('#^/(api/)?anggota(/upload)?(/(\d+))?$#', $path, $matches)) {
            $isUpload = strpos($path, 'upload') !== false;
            $id = !empty($matches[4]) ? (int)$matches[4] : ($_GET['id'] ?? null);
            $controller = new AnggotaController();

            if ($isUpload && $method === 'POST') {
                $controller->uploadPhoto($id);
                return true;
            } elseif ($method === 'GET') {
                if ($id) {
                    $controller->show($id);
                } else {
                    $controller->index();
                }
                return true;
            } elseif ($method === 'POST') {
                $controller->store();
                return true;
            } elseif ($method === 'PUT') {
                $controller->update($id);
                return true;
            } elseif ($method === 'DELETE') {
                $controller->destroy($id);
                return true;
            }
        }

        return false;
    }
}
?>
