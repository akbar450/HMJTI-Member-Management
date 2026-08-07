<?php
class Response {
    public static function json($success, $message, $data = null, $code = 200) {
        if (!headers_sent()) {
            header("Content-Type: application/json; charset=UTF-8");
        }
        
        http_response_code($code);

        $response = [
            "success" => (bool)$success,
            "message" => $message
        ];

        if ($data !== null) {
            $response["data"] = $data;
        }

        echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        exit;
    }

    public static function success($message = "Success", $data = null, $code = 200) {
        self::json(true, $message, $data, $code);
    }

    public static function error($message = "Gagal memproses permintaan", $code = 400, $data = null) {
        self::json(false, $message, $data, $code);
    }
}
?>
