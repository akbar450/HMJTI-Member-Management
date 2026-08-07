<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/User.php';
require_once __DIR__ . '/../helpers/Response.php';

class AuthController {
    public function login() {
        $data = json_decode(file_get_contents("php://input"), true);

        if (empty($data['email']) || empty($data['password'])) {
            Response::error("Email dan password wajib diisi", 400);
        }

        $database = new Database();
        $db = $database->getConnection();

        $userModel = new User($db);
        $user = $userModel->findByEmail($data['email']);

        if (!$user) {
            Response::error("Email atau password salah", 401);
        }

        // Verify password
        if (!password_verify($data['password'], $user['password']) && $data['password'] !== $user['password']) {
            Response::error("Email atau password salah", 401);
        }

        // Generate dummy session token
        $token = bin2hex(random_bytes(32));

        Response::success("Login berhasil", [
            "token" => $token,
            "user" => [
                "id" => (int)$user['id'],
                "name" => $user['name'],
                "email" => $user['email'],
                "role" => $user['role']
            ]
        ]);
    }

    public function logout() {
        Response::success("Logout berhasil");
    }
}
?>
