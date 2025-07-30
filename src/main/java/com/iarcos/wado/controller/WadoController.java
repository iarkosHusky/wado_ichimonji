package com.iarcos.wado.controller;

import java.time.zone.ZoneRules;
import java.time.zone.ZoneRulesProvider;
import java.util.NavigableMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WadoController {

	private final Logger wadLog = LogManager.getLogger(WadoController.class);

	@GetMapping(value = "/verTZDB")
	public ResponseEntity<Object> obtTZDB() {
		wadLog.debug("verTZDB");
		try {
			final NavigableMap<String, ZoneRules> zones =
			ZoneRulesProvider.getVersions("America/Mexico_City");
			return ResponseEntity.ok(zones);
		} catch (Exception expo) {
			return ResponseEntity.status(HttpStatusCode.valueOf(500))
					.body("Error en verTZDB");
		}
	}

}
